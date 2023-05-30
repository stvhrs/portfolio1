import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:cahaya/models/rekap_model.dart';
import '../helper/rupiah_format.dart';

class Rekap extends StatefulWidget {
  final double tahunTotalPerbaikan;
  final double tahunTotalBersih;
  final double tahunTotalOngkos;
  final double tahunTotalKeluar;
  final double tahunTotalSisa;
  final List<RekapModel> kasModel;
  const Rekap(this.kasModel, this.tahunTotalOngkos, this.tahunTotalKeluar,
      this.tahunTotalSisa, this.tahunTotalPerbaikan, this.tahunTotalBersih);

  @override
  State<Rekap> createState() => _RekapState();
}

class _RekapState extends State<Rekap> {
  final innerController = ScrollController();

  buildChildren() {
    return widget.kasModel.mapIndexed(
      (index, element) => Container(
        decoration: BoxDecoration(
            color: index.isEven ? Colors.grey.shade200 : Colors.white),
        padding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 15,
        ),
        child: Row(
          children: [
            Expanded(
                flex: 7,
                child: Text(element.bulan,
                    style: Theme.of(context).textTheme.displaySmall)),
            Expanded(
                flex: 7,
                child:  Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.totalOngkos)),
                    ],
                  ))),
             Expanded(
                flex: 7,
                child:  Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.totalKeluar)),
                    ],
                  ))),
           Expanded(
                flex: 7,
                child:  Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.totalSisa)),
                    ],
                  ))),
             Expanded(
                flex: 7,
                child:  Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.totalPerbaikan)),
                    ],
                  ))),
             Expanded(
                flex: 7,
                child:  Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(element.totalBersih)),
                    ],
                  ))),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 5,
        color: Colors.white, surfaceTintColor: Colors.grey.shade500,
        shadowColor: Theme.of(context).colorScheme.primary,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 12.5, left: 15),
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Bulan',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    // Expanded(
                    //     flex: 7,
                    //     child: Text(
                    //       'Mobil',
                    //       style: Theme.of(context).textTheme.displayMedium,
                    //     )),

                    Expanded(
                        flex: 7,
                        child: Text(
                          'Tarif',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Keluar',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Sisa',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Maintain',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 7,
                        child: Text(
                          'Bersih',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                  ],
                ),
              ),
              ...buildChildren(),Divider(color: Colors.black,),
              widget.kasModel.isEmpty
                  ? const SizedBox()
                 :  Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 8, left: 15, right: 20),
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
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 0),
                                    child: Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text("Rp."),
                                          Text(
                                              Rupiah.format2(
                                                  widget.tahunTotalOngkos),
                                              style: Theme.of(context)
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
                                      'Total Keluar ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 0),
                                    child: Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text("Rp."),
                                          Text(
                                              Rupiah.format2(
                                                  widget.tahunTotalKeluar),
                                              style: Theme.of(context)
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
                                      'Total Sisa ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 0),
                                    child: Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text("Rp."),
                                          Text(
                                              Rupiah.format2(
                                                  widget.tahunTotalSisa),
                                              style: Theme.of(context)
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
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 0),
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
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 0),
                                    child: Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                          Text("Rp."),
                                          Text(
                                              Rupiah.format2(
                                                  widget.tahunTotalPerbaikan),
                                              style: Theme.of(context)
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
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 0),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                        Text("Rp."),
                                        Text(
                                            Rupiah.format2(
                                                widget.tahunTotalBersih),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall)
                                      ])),
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
                        ],
                      ),
                    ),
            ]), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
