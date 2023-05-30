import 'dart:async';

import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/mobil.dart';
import 'package:cahaya/models/transaksi.dart';

import 'package:cahaya/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cahaya/services/service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/input_currency.dart';

class HpTransaksiAdd extends StatefulWidget {
  @override
  State<HpTransaksiAdd> createState() => _TransaksiAddState();
}

class _TransaksiAddState extends State<HpTransaksiAdd> {
  List<String> listSupir = [];
  List<String> listMobil = [];

  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerOngkos = TextEditingController();
  TextEditingController controlerKeluar = TextEditingController();
  TextEditingController controlerSupir = TextEditingController();
  TextEditingController controlerMobil = TextEditingController();
  TextEditingController controlerKeterangan = TextEditingController();
  TextEditingController controlerTujuan = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false)
        .listSupir
        .where((element) => element.delted == false)
        .map((e) => e.nama_supir)
        .toList()
        .forEach((element) {
      if (listSupir.contains(element)) {
      } else {
        listSupir.add(element);
      }
    });
    List<Mobil> temp =
        Provider.of<ProviderData>(context, listen: false).listMobil;

    temp.removeWhere((element) => element.terjual);
    temp.map((e) => e.nama_mobil).toList().forEach((element) {
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });
    listSupir.sort((a, b){ //sorting in ascending order
    return a[0]. toLowerCase().compareTo(b[0].toLowerCase());
});
listMobil.sort((a, b){ //sorting in ascending order
    return a[0].toLowerCase().compareTo(b[0].toLowerCase());
});
    listSupir.insert(0, 'Driver');
    listMobil.insert(0, 'Mobil');
    controlerSupir.text = 'Driver';
    controlerMobil.text = 'Mobil';
    super.initState();
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Transaksi transaksi;
  TextStyle small = const TextStyle(fontSize: 13.5);
 
  Widget _buildSize2(widget, String ket, int flex) {
    return
        //  Container(height: 50,
        //   // margin: EdgeInsets.only(
        //   //     right: ket == 'Jenis Mobil' || ket == "Ketik Tujuan" ? 0 : 50,
        //   //     bottom: ket == "ket_transaksi" ? 20 : 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //           margin: const EdgeInsets.only(
        //             right: 7,
        //           ),
        //           child: Text(
        //             "$ket :",
        //             style: const TextStyle(fontSize: 13.5),
        //           )),
        Container(
      margin: const EdgeInsets.only(bottom: 15, left: 10),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        // clipBehavior: Clip.none,
        // alignment: Alignment.centerLeft,
        children: [
         Padding(
           padding: const EdgeInsets.only(bottom: 1),
           child: Text(
                "$ket :",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Nunito"),
              ),
         ),
          
           widget,
          
        ],
      ),
    );
  }

  Widget _buildSize(widget, String ket, int flex) {
    return
        //  Container(height: 50,
        //   // margin: EdgeInsets.only(
        //   //     right: ket == 'Jenis Mobil' || ket == "Ketik Tujuan" ? 0 : 50,
        //   //     bottom: ket == "ket_transaksi" ? 20 : 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //           margin: const EdgeInsets.only(
        //             right: 7,
        //           ),
        //           child: Text(
        //             "$ket :",
        //             style: const TextStyle(fontSize: 13.5),
        //           )),
        Container(
      margin: const EdgeInsets.only(bottom: 15, left: 10),
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // clipBehavior: Clip.none,
        // alignment: Alignment.centerLeft,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$ket :",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              transaksi = Transaksi.fromMap(
                {
                  'id_transaksi': '1',
                  'id_supir': '',
                  'id_mobil': '1',
                  'tanggal': DateTime.now().toIso8601String(),
                  'ket_transaksi': '',
                  'nama_supir': '',
                  'tujuan': '',
                  'plat_mobil': '',
                  'keluar': '0',
                  'ongkosan': '0',
                  'sisa': '0',"sender":Provider.of<ProviderData>(context,listen: false).user.username
                },
              );
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  enableDrag: true,
                  isDismissible: false,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: StatefulBuilder(
                            builder: (BuildContext context,
                                    StateSetter setState) =>
                                IntrinsicHeight(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 15),
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Input Transaksi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  fontFamily: 'FreeSans',
                                                  fontSize: 19),
                                            ),
                                            const SizedBox(),
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10,top: 5),
                                          child: Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            thickness: 3,height: 0,
                                          ),
                                        ),
                                        _buildSize2(
                                            Padding(
                                              padding: const EdgeInsets.only(right: 30),
                                              child:  WebDatePicker(
                                                lastDate: DateTime.now(),
                                                height: 28,
                                                initialDate: DateTime.now(),
                                                dateformat: 'dd/MM/yyyy',
                                                onChange: (value) {
                                                  if (value != null) {
                                                    transaksi.tanggalBerangkat =
                                                        value.toIso8601String();
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ),
                                            'Tanggal',
                                            1),
                                        _buildSize(
                                            PopupMenuButton<String>(
                                              color: Colors.grey.shade300,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 5, bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(controlerMobil.text,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Nunito',
                                                            color:
                                                                Colors.black)),
                                                    const Icon(Icons
                                                        .arrow_drop_down_sharp)
                                                  ],
                                                ),
                                              ),
                                              itemBuilder: (context) =>
                                                  listMobil.map<
                                                          PopupMenuItem<
                                                              String>>(
                                                      (String value) {
                                                return PopupMenuItem<String>(
                                                  onTap: () {
                                                    setState(() {
                                                      controlerMobil.text =
                                                          value;
                                                      transaksi.mobil = value;
                                                      transaksi
                                                          .id_mobil = Provider
                                                              .of<ProviderData>(
                                                                  context,
                                                                  listen: false)
                                                          .listMobil
                                                          .firstWhere((element) =>
                                                              element
                                                                  .nama_mobil ==
                                                              value)
                                                          .id;
                                                      controlerKetMobil
                                                          .text = Provider.of<
                                                                  ProviderData>(
                                                              context,
                                                              listen: false)
                                                          .listMobil
                                                          .firstWhere((element) =>
                                                              element
                                                                  .nama_mobil ==
                                                              value)
                                                          .keterangan_mobill;
                                                    });
                                                  },
                                                  value: value,
                                                  child: Column(
                                                    children: [
                                                      Text(value.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Colors
                                                                      .black)),
                                                      const Divider(height: 0),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            'Pilih No Pol',
                                            1),
                                        _buildSize(
                                            TextFormField(
                                              style:
                                                  const TextStyle(fontSize: 13),
                                              textInputAction:
                                                  TextInputAction.next,
                                              readOnly: true,
                                              controller: controlerKetMobil,
                                              onChanged: (val) {
                                                setState(() {});
                                              },
                                            ),
                                            'Jenis Mobil',
                                            1),
                                        _buildSize(
                                            PopupMenuButton<String>(
                                              color: Colors.grey.shade300,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 5, bottom: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(controlerSupir.text,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Nunito',
                                                            color:
                                                                Colors.black)),
                                                    const Icon(Icons
                                                        .arrow_drop_down_sharp)
                                                  ],
                                                ),
                                              ),
                                              itemBuilder: (context) =>
                                                  listSupir.map<
                                                          PopupMenuItem<
                                                              String>>(
                                                      (String value) {
                                                return PopupMenuItem<String>(
                                                  onTap: () {
                                                    setState(() {
                                                      transaksi.supir = value;
                                                      controlerSupir.text =
                                                          value;
                                                      transaksi
                                                          .id_supir = Provider
                                                              .of<ProviderData>(
                                                                  context,
                                                                  listen: false)
                                                          .listSupir
                                                          .firstWhere((element) =>
                                                              element
                                                                  .nama_supir ==
                                                              value)
                                                          .id;
                                                    });
                                                  },
                                                  value: value,
                                                  child: Column(
                                                    children: [
                                                      Text(value.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: Colors
                                                                      .black)),
                                                      const Divider(height: 0),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                            'Pilih Driver',
                                            1),
                                        _buildSize(
                                            TextFormField(
                                              style:
                                                  const TextStyle(fontSize: 13),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: controlerTujuan,
                                              onChanged: (va) {
                                                transaksi.tujuan = va;
                                                setState(() {});
                                              },
                                            ),
                                            'Ketik Tujuan',
                                            1),
                                        _buildSize(
                                            TextFormField(
                                                style: const TextStyle(
                                                    fontSize: 13),
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: controlerKeterangan,
                                                onChanged: (val) {
                                                  transaksi.keterangan = val;
                                                  setState(() {});
                                                }),
                                            'Keterangan',
                                            2),
                                        _buildSize(
                                            TextFormField(
                                              style:
                                                  const TextStyle(fontSize: 13),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: controlerOngkos,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (va) {
                                                if (va.isNotEmpty &&
                                                    va.startsWith('Rp')) {
                                                  transaksi.ongkos =
                                                      Rupiah.parse(va);
                                                  if (transaksi.keluar >
                                                      Rupiah.parse(va)) {
                                                    controlerSisa.text =
                                                        'Tidak boleh minus';
                                                  } else {
                                                    controlerSisa.text =
                                                        Rupiah.format((transaksi
                                                                    .ongkos -
                                                                transaksi
                                                                    .keluar))
                                                            .toString();
                                                    transaksi.sisa =
                                                        transaksi.ongkos -
                                                            transaksi.keluar;
                                                  }
                                                } else {
                                                  transaksi.ongkos = 0;
                                                }
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                CurrencyInputFormatter()
                                              ],
                                            ),
                                            'Tarif',
                                            1),
                                        _buildSize(
                                            TextFormField(
                                              style:
                                                  const TextStyle(fontSize: 13),
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: controlerKeluar,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (va) {
                                                if (va.isNotEmpty &&
                                                    va.startsWith('Rp')) {
                                                  transaksi.keluar =
                                                      Rupiah.parse(va);

                                                  if (transaksi.ongkos <
                                                      Rupiah.parse(va)) {
                                                    controlerSisa.text =
                                                        'Tidak boleh minus';
                                                  } else {
                                                    transaksi.sisa =
                                                        transaksi.ongkos -
                                                            transaksi.keluar;
                                                    controlerSisa.text =
                                                        Rupiah.format((transaksi
                                                                    .ongkos -
                                                                transaksi
                                                                    .keluar))
                                                            .toString();
                                                    setState(() {});
                                                  }
                                                } else {
                                                  transaksi.keluar = 0;
                                                }
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                CurrencyInputFormatter()
                                              ],
                                            ),
                                            'Biaya Keluar',
                                            1),
                                        _buildSize(
                                            TextFormField(
                                              style:
                                                  const TextStyle(fontSize: 13),
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controlerSisa,
                                              readOnly: true,
                                              onChanged: (va) {
                                                if (va.isNotEmpty &&
                                                    va.startsWith('Rp')) {
                                                  transaksi.keluar =
                                                      Rupiah.parse(va);
                                                  setState(() {});
                                                } else {
                                                  transaksi.keluar = 0;
                                                }
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                CurrencyInputFormatter()
                                              ],
                                            ),
                                            'Sisa',
                                            1),
                                        Padding(
                                          padding: const EdgeInsets.all(32),
                                          child: RoundedLoadingButton(
                                            color: Colors.green,
                                            elevation: 10,
                                            successColor: Colors.green,
                                            errorColor: Colors.red,
                                            controller: _btnController,
                                            onPressed: (transaksi.sisa <= 0 ||
                                                    transaksi.supir ==
                                                        'Driver' ||
                                                    transaksi.tujuan.isEmpty ||
                                                    controlerSisa.text ==
                                                        'Tidak boleh minus' ||
                                                    transaksi.mobil ==
                                                        'Mobil' ||
                                                    transaksi.ongkos == 0
                                                   )
                                                ? null
                                                : () async {
                                                    var data = await Service
                                                        .postTransaksi({
                                                      "plat_mobil":
                                                          transaksi.mobil,
                                                      "id_mobil":
                                                          transaksi.id_mobil,
                                                      "id_supir":
                                                          transaksi.id_supir,
                                                      "nama_supir":
                                                          transaksi.supir,
                                                      "tanggal": transaksi
                                                          .tanggalBerangkat,
                                                      "ket_transaksi":
                                                          transaksi.keterangan,
                                                      "tujuan":
                                                          transaksi.tujuan,
                                                      "ongkosan": transaksi
                                                          .ongkos
                                                          .toString(),
                                                      "keluar": transaksi.keluar
                                                          .toString(),
                                                      "sisa": transaksi.sisa
                                                          .toString(),"sender":Provider.of<ProviderData>(context,listen: false).user.username
                                                    });

                                                    if (data != null) {
                                                     
                                                    } else {
                                                      _btnController.error();
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 1),
                                                          () {});
                                                      _btnController.reset();
                                                      return;
                                                    }

                                                    _btnController.success();

                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 1), () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      controlerSisa.text = '';
                                                      controlerOngkos.text = '';
                                                      controlerKeluar.text = '';
                                                      controlerSupir.text =
                                                          'Pilih Driver';
                                                      controlerMobil.text =
                                                          'Pilih No Pol';
                                                      controlerKeterangan.text =
                                                          '';
                                                      controlerTujuan.text = '';
                                                      controlerKetMobil.text =
                                                          '';
                                                      Provider.of<ProviderData>(
                                                              context,
                                                              listen: false)
                                                          .addTransaksi(
                                                              transaksi);
                                                      transaksi =
                                                          Transaksi.fromMap(
                                                        {
                                                          "id_transaksi": "0",
                                                          "id_mobil": "0",
                                                          "plat_mobil":
                                                              'Pilih No Pol',
                                                          "id_supir": "0",
                                                          "nama_supir":
                                                              "Pilih Supir",
                                                          "tanggal": DateTime
                                                                  .now()
                                                              .toIso8601String(),
                                                          "ket_transaksi": "k",
                                                          "tujuan": "0",
                                                          "ongkosan": "0",
                                                          "keluar": "0",
                                                          "sisa": "0","sender":Provider.of<ProviderData>(context,listen: false).user.username
                                                        },
                                                      );
                                                    });
                                                  },
                                            child: const Text('Tambah',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    );
                  });
            }));
  }
}
