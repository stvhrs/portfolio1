import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:cahaya/kas/kas.dart';
import 'package:cahaya/models/kas_tahun.dart';
import 'package:cahaya/models/transaksi.dart';
import 'package:cahaya/print2.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../helper/laporandrop.dart';
import '../models/keuangan_bulanan.dart';

import '../models/perbaikan.dart';

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

class KasTahun extends StatefulWidget {
  const KasTahun({super.key});

  @override
  State<KasTahun> createState() => _KasTahunState();
}

class _KasTahunState extends State<KasTahun> {
  List<int> tahun = [];
  bool enable = true;
  String value = "Semua";
  List<KasModel> listKas = [];
  final innerController = ScrollController();
  List<KasModel> backup = [];
  int ropdownValue2 = DateTime.now().year;
  @override
  void didChangeDependencies() {
    for (var element in Provider.of<ProviderData>(context).listTransaksi) {
      if (!tahun.contains(DateTime.parse(element.tanggalBerangkat).year)) {
        tahun.add(DateTime.parse(element.tanggalBerangkat).year);
      }
    }
    if (!tahun.contains(ropdownValue2)) {
      tahun.add(ropdownValue2);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    listKas.clear;

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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TahunPrint(listKas),
                ));
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
                          menuItemStyleData:
                              const MenuItemStyleData(height: 36),
                          value: ropdownValue2,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView(
                      padding: EdgeInsets.only(right: 20,top: 20),
                      children: Provider.of<ProviderData>(context)
                          .backupListMobil
                          .where((element) => value == "Semua"
                              ? element.nama_mobil.isNotEmpty
                              : element.nama_mobil == value)
                          .map((e) {
                        double tahunTotalPerbaikan = 0;
                        double tahunTotalBersih = 0;
                        double tahunTotalOngkos = 0;
                        double tahunTotalKeluar = 0;
                        double tahunTotalSisa = 0;
                        KasModel kasModel = KasModel(e.nama_mobil, [], 0, 0, 0,
                            0, ropdownValue2.toString());
                        for (var moon in list) {
                          List<Transaksi> transaksiBulanIni = [];
                          double totalPerbaikan = 0;
                          double totalBersih = 0;
                          double totalOngkos = 0;
                          double totalKeluar = 0;
                          double totalSisa = 0;
                          List<Perbaikan> listPerbaikan = [];

                          transaksiBulanIni = Provider.of<ProviderData>(context)
                              .listTransaksi
                              .where((element) =>
                                  element.mobil == e.nama_mobil &&
                                  DateTime.parse(element.tanggalBerangkat)
                                          .month ==
                                      list.indexOf(moon) + 1 &&
                                  DateTime.parse(element.tanggalBerangkat)
                                          .year ==
                                      ropdownValue2)
                              .toList();
                          e.perbaikan = Provider.of<ProviderData>(context)
                              .backupListPerbaikan
                              .where((element) =>
                                  element.mobil == e.nama_mobil &&
                                  DateTime.parse(element.tanggal).month ==
                                      list.indexOf(moon) + 1 &&
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
                          for (var perbaikan in e.perbaikan) {
                            totalPerbaikan = totalPerbaikan + perbaikan.harga;
                            listPerbaikan.add(perbaikan);
                          }
                          totalBersih -= totalPerbaikan;

                          KeuanganBulanan data = KeuanganBulanan(
                              e.nama_mobil,
                              transaksiBulanIni,
                              listPerbaikan,
                              totalBersih,
                              totalOngkos,
                              totalKeluar,
                              totalSisa,
                              totalPerbaikan,
                              list[list.indexOf(moon)]);

                          kasModel.listBulananMobil.add(data);

                          tahunTotalSisa += totalSisa;
                          tahunTotalBersih += totalBersih;
                          tahunTotalKeluar += totalKeluar;
                          tahunTotalOngkos += totalOngkos;
                          tahunTotalPerbaikan += totalPerbaikan;
                        }
                        if (tahunTotalSisa < 1 && tahunTotalPerbaikan < 1) {
                          return const SizedBox();
                        }
                        if (!listKas
                            .map((e) => e.namaMobil)
                            .toList()
                            .contains(kasModel.namaMobil)) {
                          listKas.add(kasModel);
                          backup.add(kasModel);
                        }

                        return Kas(
                            kasModel,
                            tahunTotalOngkos,
                            tahunTotalKeluar,
                            tahunTotalSisa,
                            tahunTotalPerbaikan,
                            tahunTotalBersih);
                      }).toList(),
                    ),
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
                    if (listKas
                        .map((e) => e.namaMobil.toString())
                        .contains(va)) {
                      var keuangan = listKas
                          .firstWhere((element) => element.namaMobil == va);
                      listKas = [keuangan];
                    }

                   
                  } else {
                    // listKas =
                    //     Provider.of<ProviderData>(context, listen: false)
                    //         .listKas;
                    // data = Provider.of<ProviderData>(context, listen: false)
                    //     .backupListMobil;
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
