import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:cahaya/bulanan/bulanan.dart';
import 'package:cahaya/helper/laporandrop.dart';

import 'package:cahaya/models/keuangan_bulanan.dart';
import 'package:cahaya/models/mobil.dart';
import 'package:cahaya/models/perbaikan.dart';
import 'package:cahaya/models/transaksi.dart';
import 'package:cahaya/prints.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

List<String> list = <String>[
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember'
];

class LaporanBulanan extends StatefulWidget {
  const LaporanBulanan({super.key});

  @override
  State<LaporanBulanan> createState() => _LaporanBulananState();
}

class _LaporanBulananState extends State<LaporanBulanan> {
  List<int> tahun = [];
  bool enable = true;
  final innerController = ScrollController();

  String dropdownValue = list[DateTime.now().month - 1];
  int ropdownValue2 = DateTime.now().year;
  late List<Mobil> data;
  List<KeuanganBulanan> printed = [];
  List<KeuanganBulanan> backup = [];
  String value = "Semua";

  @override
  void initState() {
    data = Provider.of<ProviderData>(context, listen: false).backupListMobil;
    for (var element
        in Provider.of<ProviderData>(context, listen: false).listTransaksi) {
      if (!tahun.contains(DateTime.parse(element.tanggalBerangkat).year)) {
        tahun.add(DateTime.parse(element.tanggalBerangkat).year);
      }
    }
    if (!tahun.contains(ropdownValue2)) {
      tahun.add(ropdownValue2);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data.sort((a, b) {
      //sorting in ascending order
      return a.nama_mobil[0]
          .toLowerCase()
          .compareTo(b.nama_mobil[0].toLowerCase());
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 50, top: 50),
          child: Padding(
              padding: const EdgeInsets.only(),
              child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.print,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Print Laporan",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (printed.isNotEmpty) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        data.sort((a, b) {
                          //sorting in ascending order
                          return a.nama_mobil[0]
                              .toLowerCase()
                              .compareTo(b.nama_mobil[0].toLowerCase());
                        });
                        return LaporanPrint(printed);
                      }));
                    }
                  }))),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        DropdownButton2<int>(
                          value: ropdownValue2,
                          menuItemStyleData:
                              const MenuItemStyleData(height: 36),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          underline: Container(
                            height: 2.5,
                            margin: const EdgeInsets.only(top: 5),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onChanged: (int? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              ropdownValue2 = value!;
                            });
                          },
                          items: tahun.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      color: Colors.black)),
                            );
                          }).toList(),
                        ),
                        DropdownButton2<String>(
                          menuItemStyleData:
                              const MenuItemStyleData(height: 36),
                          value: dropdownValue,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          underline: Container(
                            height: 2.5,
                            margin: const EdgeInsets.only(top: 5),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      color: Colors.black)),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.89,
                    child: ListView(
                        padding: EdgeInsets.only(right: 5, top: 20),
                        children: data
                            .where((element) => value == "Semua"
                                ? element.nama_mobil.isNotEmpty
                                : element.nama_mobil == value)
                            .map((e) {
                          List<Transaksi> transaksiBulanIni = [];
                          double totalPerbaikan = 0;
                          double totalBersih = 0;
                          List<Perbaikan> listPerbaikan = [];
                          double totalOngkos = 0;
                          double totalKeluar = 0;
                          double totalSisa = 0;

                          transaksiBulanIni = Provider.of<ProviderData>(context)
                              .listTransaksi
                              .where((element) =>
                                  element.mobil == e.nama_mobil &&
                                  DateTime.parse(element.tanggalBerangkat)
                                          .month ==
                                      list.indexOf(dropdownValue) + 1 &&
                                  DateTime.parse(element.tanggalBerangkat)
                                          .year ==
                                      ropdownValue2)
                              .toList();
                          e.perbaikan = Provider.of<ProviderData>(context)
                              .backupListPerbaikan
                              .where((element) =>
                                  element.mobil == e.nama_mobil &&
                                  DateTime.parse(element.tanggal).month ==
                                      list.indexOf(dropdownValue) + 1 &&
                                  DateTime.parse(element.tanggal).year ==
                                      ropdownValue2)
                              .toList();

                          // }
                          for (var element in transaksiBulanIni) {
                            totalBersih += element.sisa;
                            totalOngkos += element.ongkos;
                            totalKeluar += element.keluar;
                            totalSisa += element.sisa;
                          }
                          for (var Perbaikan in e.perbaikan) {
                            totalPerbaikan = totalPerbaikan + Perbaikan.harga;
                            listPerbaikan.add(Perbaikan);
                          }
                          totalBersih -= totalPerbaikan;
                          transaksiBulanIni.sort((a, b) =>
                              DateTime.parse(b.tanggalBerangkat).compareTo(
                                  DateTime.parse(a.tanggalBerangkat)));
                          KeuanganBulanan data = KeuanganBulanan(
                              e.nama_mobil,
                              transaksiBulanIni,
                              listPerbaikan,
                              totalBersih,
                              totalOngkos,
                              totalKeluar,
                              totalSisa,
                              totalPerbaikan,
                              list[list.indexOf(dropdownValue)]);
                          if (transaksiBulanIni.isEmpty && totalPerbaikan < 1) {
                            return const SizedBox();
                          }

                          if (value != "Semua") {
                            var keuangan = backup.firstWhere(
                                (element) => element.namaMobil == value,
                                orElse: () {
                              return backup[0];
                            });
                            printed = [keuangan];
                          } else {
                            if (!printed
                                .map((e) => e.namaMobil)
                                .contains(data.namaMobil)) {
                              printed.add(data);
                              backup.add(data);
                            }
                          }

                          return Bulanan(data);
                        }).toList()),
                  ),
                ]),
          ),
          Positioned(
            top: 15,
            child: SizedBox(
              width: 200,
              child: LaporanDropDownField(
                enabled: enable,
                value: value,
                height: 30,
                items: Provider.of<ProviderData>(context, listen: false)
                    .backupListMobil
                    .map((e) => e.nama_mobil.toString())
                    .toList()
                  ..add("Semua"),
                onValueChanged: (va) {
                  value = va;
                  if (va != "Semua") {
                    if (printed
                        .map((e) => e.namaMobil.toString())
                        .contains(va)) {
                      var keuangan = printed
                          .firstWhere((element) => element.namaMobil == va);
                      printed = [keuangan];
                    }

                    // enable = false;
                  } else {
                    data = Provider.of<ProviderData>(context, listen: false)
                        .backupListMobil;
                  }
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
