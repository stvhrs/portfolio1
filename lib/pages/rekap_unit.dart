import 'package:cahaya/widget_print_rekap.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:cahaya/models/rekap_model.dart';
import 'package:cahaya/models/transaksi.dart';
import 'package:cahaya/pages/rekap_tile.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../models/perbaikan.dart';

class RekapUnit extends StatefulWidget {
  const RekapUnit({super.key});

  @override
  State<RekapUnit> createState() => _RekapUnitState();
}

class _RekapUnitState extends State<RekapUnit> {
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
  List<int> tahun = [];
  List<RekapModel> listKas = [];
  final innerController = ScrollController();

  int ropdownValue2 = DateTime.now().year;
  @override
  void didChangeDependencies() {
    for (var element
        in Provider.of<ProviderData>(context, listen: false).listTransaksi) {
      if (!tahun.contains(DateTime.parse(element.tanggalBerangkat).year)) {
        tahun.add(DateTime.parse(element.tanggalBerangkat).year);
      }
    }
    if (!tahun.contains(ropdownValue2)) {
      tahun.add(ropdownValue2);
    }
    super.didChangeDependencies();
    test();
  }

  double tahunTotalSisa = 0;
  double tahunTotalBersih = 0;
  double tahunTotalKeluar = 0;
  double tahunTotalOngkos = 0;
  double tahunTotalPerbaikan = 0;
  test() {
    for (var moon in list) {
      List<Transaksi> transaksiBulanIni = [];
      double totalPerbaikan = 0;
      double totalBersih = 0;
      double totalOngkos = 0;
      double totalKeluar = 0;
      double totalSisa = 0;
      List<Perbaikan> listPerbaikan = [];

      transaksiBulanIni = Provider.of<ProviderData>(context, listen: false)
          .listTransaksi
          .where((element) =>
              DateTime.parse(element.tanggalBerangkat).month ==
                  list.indexOf(moon) + 1 &&
              DateTime.parse(element.tanggalBerangkat).year == ropdownValue2)
          .toList();
      List<Perbaikan> bulanPerbaikan = Provider.of<ProviderData>(context,
              listen: false)
          .backupListPerbaikan
          .where((element) =>
              DateTime.parse(element.tanggal).month == list.indexOf(moon) + 1 &&
              DateTime.parse(element.tanggal).year == ropdownValue2)
          .toList();

      // }
      for (var element in transaksiBulanIni) {
        totalBersih += element.sisa;
        totalOngkos += element.ongkos;
        totalKeluar += element.keluar;
        totalSisa += element.sisa;
      }
      for (var perbaikan in bulanPerbaikan) {
        totalPerbaikan = totalPerbaikan + perbaikan.harga;
        listPerbaikan.add(perbaikan);
      }
      listKas.add(RekapModel(totalSisa, totalKeluar, totalOngkos,
          totalPerbaikan, totalSisa - totalPerbaikan, moon));
    }

    for (var element in listKas) {
      tahunTotalSisa += element.totalSisa;
      tahunTotalBersih += element.totalSisa - element.totalPerbaikan;
      tahunTotalKeluar += element.totalKeluar;
      tahunTotalOngkos += element.totalOngkos;
      tahunTotalPerbaikan += element.totalPerbaikan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 150, top: 10),
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
                      builder: (context) => Rekapitulasi(
                          listKas,
                          tahunTotalOngkos,
                          tahunTotalKeluar,
                          tahunTotalSisa,
                          tahunTotalPerbaikan,
                          tahunTotalBersih),
                    ));
                  }))),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              child: Row(
                children: [
                  DropdownButton2<int>(
                    value: ropdownValue2,
                    menuItemStyleData: const MenuItemStyleData(height: 36),
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
                        listKas.clear();
                        tahunTotalSisa = 0;
                        tahunTotalBersih = 0;
                        tahunTotalKeluar = 0;
                        tahunTotalOngkos = 0;
                        tahunTotalPerbaikan = 0;
                        ropdownValue2 = value!;
                        test();
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
            Rekap(listKas, tahunTotalOngkos, tahunTotalKeluar, tahunTotalSisa,
                tahunTotalPerbaikan, tahunTotalBersih)
          ]),
        ),
      ),
    );
  }
}
