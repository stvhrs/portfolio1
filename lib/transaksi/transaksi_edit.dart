import 'dart:async';

import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/transaksi.dart';

import 'package:cahaya/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';
import '../services/service.dart';
import 'datepicer.dart';

class TransaksiEdit extends StatelessWidget {
  Transaksi transaksi;
  TransaksiEdit(this.transaksi);

  List<String> listSupir = [];
  List<String> listMobil = [];
  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  Widget _buildSize(widget, String ket, int flex) {
    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.14 * flex,
      // margin: EdgeInsets.only(right: ket == 'Tanggal' ? 0 : 50, bottom: 30),
      child: Container(
        margin: EdgeInsets.only(
            right: ket == 'Jenis Mobil' || ket == 'Ketik Tujuan' ? 0 : 50,
            bottom: ket == 'Keterangan' ? 40 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 7, top: 7),
                child: Row(
                  children: [
                    Text(
                      '$ket :',
                      style: const TextStyle(fontSize: 13.5),
                    ),
                  ],
                )),
            SizedBox(height: 36, child: widget)
          ],
        ),
      ),
    );
  }

  Widget _buildSize2(widget, String ket, int flex) {
    return Expanded(
      // width: MediaQuery.of(context).size.width * 0.14 * flex,
      // margin: EdgeInsets.only(right: ket == 'Tanggal' ? 0 : 50, bottom: 30),
      child: Container(
        margin: EdgeInsets.only(
            right: ket == 'Jenis Mobil' || ket == 'Ketik Tujuan' ? 0 : 50,
            bottom: ket == 'Keterangan' ? 40 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 7, top: 7),
                child: Row(
                  children: [
                    Text(
                      '$ket :',
                      style: const TextStyle(fontSize: 13.5),
                    ),
                  ],
                )),
            widget
          ],
        ),
      ),
    );
  }

  FocusNode fd = FocusNode();
  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderData>(context, listen: false)
        .listSupir
        .map((e) => e.nama_supir)
        .toList()
        .forEach((element) {
      if (listSupir.contains(element)) {
      } else {
        listSupir.add(element);
      }
    });
    Provider.of<ProviderData>(context, listen: false)
        .listMobil
        .map((e) => e.nama_mobil)
        .toList()
        .forEach((element) {
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });
    FocusNode fd = FocusNode();
    controlerSisa.text = Rupiah.format(transaksi.sisa);
    controlerKetMobil.text = transaksi.keterangan_mobill;
    return IconButton(
        icon: const Icon(Icons.edit, color: Colors.green),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const Text(
                          'Edit Transaksi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 13,
                                  color: Colors.red,
                                ),
                              )),
                        ),
                      ],
                    ),
                    titlePadding: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 20, left: 20, right: 20, top: 15),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildSize(
                                      Picker(
                                        fd: fd,
                                        lastDate: DateTime.now(),
                                        height: 60,
                                        initialDate: DateTime.parse(
                                            transaksi.tanggalBerangkat),
                                        dateformat: 'dd/MM/yyyy',
                                        onChange: (value) {
                                          if (value != null) {
                                            transaksi.tanggalBerangkat =
                                                value.toIso8601String();
                                          }
                                        },
                                      ),
                                      'Tanggal',
                                      1),
                                  _buildSize2(
                                      DropDownField(
                                        value: transaksi.supir,
                                        onValueChanged: (val) {
                                          transaksi.supir = val;
                                          transaksi.id_supir =
                                              Provider.of<ProviderData>(context,
                                                      listen: false)
                                                  .backupListSupir
                                                  .firstWhere((element) =>
                                                      element.nama_supir ==
                                                      transaksi.supir)
                                                  .id;
                                        },
                                        items: listSupir,
                                      ),
                                      'Pilih Driver',
                                      1),
                                  _buildSize2(
                                      DropDownField(
                                        value: transaksi.mobil,
                                        onValueChanged: (val) {
                                          transaksi.mobil = val;
                                          transaksi.id_mobil =
                                              Provider.of<ProviderData>(context,
                                                      listen: false)
                                                  .backupListMobil
                                                  .firstWhere((element) =>
                                                      element.nama_mobil ==
                                                      transaksi.mobil)
                                                  .id;
                                          controlerKetMobil.text =
                                              Provider.of<ProviderData>(context,
                                                      listen: false)
                                                  .listMobil
                                                  .firstWhere((element) =>
                                                      element.nama_mobil == val)
                                                  .keterangan_mobill;
                                        },
                                        items: listMobil,
                                      ),
                                      'Pilih No Pol',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        readOnly: true,
                                        controller: controlerKetMobil,
                                        onChanged: (val) {},
                                      ),
                                      'Jenis Mobil',
                                      1),
                                ],
                              ),
                              Row(
                                children: [
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        initialValue:
                                            Rupiah.format(transaksi.ongkos),
                                        onChanged: (va) {
                                          if (va.isNotEmpty &&
                                              va.startsWith('Rp')) {
                                            transaksi.ongkos = Rupiah.parse(va);
                                            if (transaksi.keluar >
                                                Rupiah.parse(va)) {
                                              controlerSisa.text =
                                                  'Tidak boleh minus';
                                            } else {
                                              controlerSisa.text =
                                                  Rupiah.format(
                                                          (Rupiah.parse(va) -
                                                              transaksi.keluar))
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
                                      'Biaya Ongkos',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        initialValue:
                                            Rupiah.format(transaksi.keluar),
                                        onChanged: (va) {
                                          if (va.isNotEmpty &&
                                              va.startsWith('Rp')) {
                                            transaksi.keluar = Rupiah.parse(va);
                                            if (transaksi.ongkos <
                                                Rupiah.parse(va)) {
                                              controlerSisa.text =
                                                  'Tidak boleh minus';
                                            } else {
                                              controlerSisa.text =
                                                  Rupiah.format(
                                                          (transaksi.ongkos -
                                                              Rupiah.parse(va)))
                                                      .toString();
                                              transaksi.sisa =
                                                  transaksi.ongkos -
                                                      transaksi.keluar;
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
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        controller: controlerSisa,
                                        readOnly: true,
                                        onChanged: (va) {
                                          if (va.isNotEmpty &&
                                              va.startsWith('Rp')) {
                                            transaksi.keluar = Rupiah.parse(va);
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
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        initialValue: transaksi.tujuan,
                                        onChanged: (va) {
                                          transaksi.tujuan = va;
                                        },
                                      ),
                                      'Ketik Tujuan',
                                      1),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _buildSize(
                                      TextFormField(
                                          style: const TextStyle(fontSize: 13),
                                          textInputAction: TextInputAction.next,
                                          initialValue: transaksi.keterangan,
                                          onChanged: (val) {
                                            transaksi.keterangan = val;
                                          }),
                                      'Keterangan',
                                      2),
                                  _buildSize(
                                      Text(transaksi.sender), 'Penginput', 4),
                                  //                               ElevatedButton.icon(
                                  // icon: const Icon(
                                  //   Icons.add,
                                  //   color: Colors.white,
                                  // ),
                                  // label: const Text(
                                  //   'Masuk Ringkasan',
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                  // style: ButtonStyle(
                                  //     padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
                                  // onPressed: () {})
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RoundedLoadingButton(
                                      width: 120,
                                      color: Colors.red,
                                      controller:
                                          RoundedLoadingButtonController(),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Batal',
                                          style:
                                              TextStyle(color: Colors.white))),
                                  RoundedLoadingButton(
                                    width: 120,
                                    color: Colors.green,
                                    elevation: 10,
                                    successColor: Colors.green,
                                    errorColor: Colors.red,
                                    controller: _btnController,
                                    onPressed: () async {
                                      if ((transaksi.sisa <= 0 ||
                                          transaksi.supir.isEmpty ||
                                          transaksi.mobil.isEmpty ||
                                          transaksi.tujuan.isEmpty ||
                                          transaksi.ongkos == 0 ||
                                          controlerSisa.text ==
                                              "Tidak boleh minus")) {
                                        _btnController.error();
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        _btnController.reset();
                                        return;
                                      }

                                      var data = await Service.updateTransaksi({
                                        "id_transaksi": transaksi.id,
                                        "id_mobil": transaksi.id_mobil,
                                        "id_supir": transaksi.id_supir,
                                        "plat_mobil": transaksi.mobil,
                                        "nama_supir": transaksi.supir,
                                        "tanggal": transaksi.tanggalBerangkat,
                                        "ket_transaksi": transaksi.keterangan,
                                        "tujuan": transaksi.tujuan,
                                        "ongkosan": transaksi.ongkos.toString(),
                                        "keluar": transaksi.keluar.toString(),
                                        "sisa": transaksi.sisa.toString(),
                                        "sender": Provider.of<ProviderData>(
                                                context,
                                                listen: false)
                                            .user
                                            .username
                                      });

                                      if (data != null) {
                                        Provider.of<ProviderData>(context,
                                                listen: false)
                                            .updateTransaksi(data);
                                        _btnController.success();
                                      } else {
                                        _btnController.error();
                                        await Future.delayed(
                                            const Duration(seconds: 1), () {});
                                        _btnController.reset();
                                        return;
                                      }
                                      await Future.delayed(
                                          const Duration(seconds: 1), () {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Text('Edit',
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              ),
                            ])),
                          ),
                        ),
                      ),
                    ));
              });
        });
  }
}
