import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cahaya/models/keuangan_bulanan.dart';
import 'package:collection/collection.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../helper/rupiah_format.dart';

class Bulanan extends StatefulWidget {
  final KeuanganBulanan laporanBulanan;
  const Bulanan(this.laporanBulanan);

  @override
  State<Bulanan> createState() => _BulananState();
}

class _BulananState extends State<Bulanan> {
  final innerController = ScrollController();

  buildChildren() {
    if (widget.laporanBulanan.transaksiBulanIni.isEmpty) {
      return [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: const Center(child: Text('Tidak Ada Transaksi')))
      ];
    } else {
      return widget.laporanBulanan.transaksiBulanIni
          .mapIndexed((index, element) => Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: index.isEven ? Colors.grey.shade200 : Colors.white),
                padding: const EdgeInsets.only(
                  top: 2,
                  bottom: 2,
                  left: 15,
                ),
                child: Row(children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                          textAlign: TextAlign.left,
                          '${DateTime.parse(element.tanggalBerangkat).day}, ${DateFormat('EEEE', "id_ID").format(DateTime.parse(element.tanggalBerangkat))}')),
                  Expanded(
                      flex: 4,
                      child: Text(
                        textAlign: TextAlign.left,
                        element.supir,
                      )),
                  Expanded(
                      flex: 10,
                      child: Text(
                        textAlign: TextAlign.left,
                        element.tujuan,
                      )),
                  Expanded(
                      flex: 7,
                      child:  Container(
                  margin: EdgeInsets.only(right: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.ongkos)),
                    ],
                  ))),
                  Expanded(
                      flex: 7,
                      child:  Container(
                  margin: EdgeInsets.only(right: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.keluar)),
                    ],
                  ))),

                  Expanded(
                      flex: 7,
                      child:  Container(
                  margin: EdgeInsets.only(right: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.sisa)),
                    ],
                  ))),
                  // Expanded(
                  //   flex: 7,
                  //   child: Text(textAlign: TextAlign.left,
                  //       textAlign: TextAlign.left,
                  //       element.listPerbaikan.isEmpty
                  //           ? ''
                  //           : Rupiah.format(totalPerbaikan.totalPerbaikan(
                  //               element.listPerbaikan)),
                  //       ),
                  // ),4
                ]),
              ));
    }
  }

  buildChildren2() {
    if (widget.laporanBulanan.pengeluranBulanIni.isEmpty) {
      return [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
            child: const Center(child: Text('Tidak Ada Perbaikan')))
      ];
    } else {
      return widget.laporanBulanan.pengeluranBulanIni.mapIndexed(
        (index, element) => Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: index.isEven ? Colors.grey.shade200 : Colors.white),
          padding: const EdgeInsets.only(
            top: 2,
            bottom: 2,
            left: 15,
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                      textAlign: TextAlign.left,
                      '${DateTime.parse(element.tanggal).day}, ${DateFormat('EEEE', "id_ID").format(DateTime.parse(element.tanggal))}')),
              Expanded(
                  flex: 5,
                  child: Text(
                    textAlign: TextAlign.left,
                    element.jenis,
                  )),

              Expanded(
                  flex: 5,
                  child:  Container(margin: EdgeInsets.only(right: 120),
                 
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(element.harga))
                      ]))),
              Expanded(
                  flex: 6,
                  child: Text(
                    textAlign: TextAlign.left,
                    element.keterangan,
                  )),

              // Expanded(
              //   flex: 7,
              //   child: Text(textAlign: TextAlign.left,
              //       textAlign: TextAlign.left,
              //       element.listPerbaikan.isEmpty
              //           ? ''
              //           : Rupiah.format(totalPerbaikan.totalPerbaikan(
              //               element.listPerbaikan)),
              //       ),
              // ),
            ],
          ),
        ),
      );
    }
  }

  int currentSegment = 0;
  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment = newValue!;
    });
  }

  final children = <int, Widget>{
    0: const Text('Transaksi',
        style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.green)),
    1: const Text('Pemeliharaan',
        style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.red)),
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 5,
        color: Colors.white, surfaceTintColor: Colors.white,
        shadowColor: Theme.of(context).colorScheme.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 7.5, bottom: 7.5),
                  child: Text(
                    textAlign: TextAlign.left,
                    '${widget.laporanBulanan.namaMobil} - ${widget.laporanBulanan.bulan}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CupertinoSlidingSegmentedControl<int>(
                    children: children,
                    onValueChanged: onValueChanged,
                    groupValue: currentSegment,
                  ),
                ),
                const Spacer(),
              
              ],
            ),
            currentSegment == 0
                ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Tanggal',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Driver',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 10,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Tujuan',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Tarif',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Keluar',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 7,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Sisa',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                          ],
                        ),
                      ),
                      ...buildChildren(),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.red.shade600),
                        padding:
                            const EdgeInsets.only(top: 5, bottom: 5, left: 15),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Tanggal',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Jenis',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Biaya Maintain',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                            Expanded(
                                flex: 6,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  'Keterangan',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )),
                          ],
                        ),
                      ),
                      ...buildChildren2(),
                    ],
                  ),Divider(color: Colors.black,),
            widget.laporanBulanan.transaksiBulanIni.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 8, left: 15, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    'Total Ongkos ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                child:  Container(
                 
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget.laporanBulanan.totalOngkos), style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                      ]))
                              ),
                            ),
                            const Expanded(flex: 7, child: SizedBox()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Divider(
                                height: 7,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const Expanded(flex: 9, child: SizedBox())
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    'Total Keluar ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                child: Container(
                 
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget.laporanBulanan.totalKeluar), style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                      ]))
                              ),
                            ),
                            const Expanded(flex: 7, child: SizedBox()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Divider(
                                height: 7,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const Expanded(flex: 9, child: SizedBox())
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                child: Text(
                                    textAlign: TextAlign.left,
                                    'Total Sisa ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                child:  Container(
                 
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget.laporanBulanan.totalSisa), style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                      ]))
                              ),
                            ),
                            const Expanded(flex: 7, child: SizedBox()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Divider(
                                height: 7,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const Expanded(flex: 9, child: SizedBox())
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(
                                    textAlign: TextAlign.left,
                                    'Total Maintain',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Container(
                 
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget.laporanBulanan.totalPerbaikan), style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                      ]))),
                            ),
                            const Expanded(flex: 7, child: SizedBox()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Divider(
                                height: 7,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const Expanded(flex: 9, child: SizedBox())
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(
                                      textAlign: TextAlign.left,
                                      'Total Bersih ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)),
                            ),
                            Expanded(
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 0),
                                  child: Container(
                 
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget.laporanBulanan.totalBersih), style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                      ])),),
                            ),
                            const Expanded(flex: 7, child: SizedBox()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Divider(
                                height: 7,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const Expanded(flex: 9, child: SizedBox())
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
