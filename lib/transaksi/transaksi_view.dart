
import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/transaksi.dart';

import 'package:cahaya/providerData/providerData.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/input_currency.dart';
import '../models/mobil.dart';
import 'datepicer.dart';

class TransaksiView extends StatefulWidget {
  Transaksi transaksi;
  TransaksiView(this.transaksi);

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  List<String> listSupir = [];
  List<String> listMobil = [];
  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();

  @override
  void initState() {

    transaksi=widget.transaksi;
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
   List<Mobil> temp=Provider.of<ProviderData>(context, listen: false)
        .listMobil;

        temp.removeWhere((element) => element.terjual);
    temp
        .map((e) => e.nama_mobil)
        .toList()
        .forEach((element) {
      
      //  controlerKetMobil.text=temp.firstWhere((element) => element.nama_mobil==widget.transaksi.mobil).nama_mobil;
      controlerSisa.text=widget.transaksi.sisa.toString();
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });
controlerKetMobil.text=transaksi.keterangan_mobill;
    super.initState();
  }
 FocusNode fd = FocusNode();

  late Transaksi transaksi;
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
           SizedBox(height: 36,child:  widget)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
       
            icon: const Icon(
              Icons.remove_red_eye,
              color: Colors.grey),
            
           
          
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
                              'View Transaksi',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        content: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    IntrinsicHeight(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20, top: 15),
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildSize(
                                                    Picker(lastDate: DateTime.now(),fd:fd ,
                                                height: 60,
                                                initialDate:DateTime.parse(widget.transaksi.tanggalBerangkat) ,
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
                                          _buildSize(
                                             TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly: true,initialValue: widget.transaksi.supir,enabled: false,
                                                onChanged: (val) {
                                                  transaksi.supir = val;
                                                },
                                              
                                              ),
                                              'Pilih Driver',
                                              1),
                                          _buildSize(
                                             TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly: true,initialValue: widget.transaksi.mobil,enabled: false,
                                                onChanged: (val) {
                                                  transaksi.mobil = val;
                                                  controlerKetMobil
                                                      .text = Provider.of<
                                                              ProviderData>(
                                                          context,
                                                          listen: false)
                                                      .listMobil
                                                      .firstWhere((element) =>
                                                          element.nama_mobil ==
                                                          val)
                                                      .keterangan_mobill;
                                                },
                                             
                                              ),
                                              'Pilih No Pol',
                                              1),
                                          _buildSize(
                                              TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly:true,
                                              
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
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly:true,initialValue:Rupiah.format(widget.transaksi.ongkos) ,
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
                                                      controlerSisa
                                                          .text = Rupiah.format(
                                                              (transaksi
                                                                      .ongkos -
                                                                  transaksi
                                                                      .keluar))
                                                          .toString();
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
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly:true,initialValue: Rupiah.format(widget.transaksi.keluar),
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
                                                      controlerSisa
                                                          .text = Rupiah.format(
                                                              (transaksi
                                                                      .ongkos -
                                                                  transaksi
                                                                      .keluar))
                                                          .toString();
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
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly:true,
                                               initialValue: Rupiah.format(widget.transaksi.sisa),
                                          
                                                onChanged: (va) {
                                                  if (va.isNotEmpty &&
                                                      va.startsWith('Rp')) {
                                                    transaksi.keluar =
                                                        Rupiah.parse(va);
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
                                          _buildSize(TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly:true,initialValue: widget.transaksi.tujuan,
                                            onChanged: (va) {
                                              transaksi.tujuan = va;
                                            },
                                          ), 'Ketik Tujuan', 1),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          _buildSize(
                                              TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,readOnly:true,initialValue: widget.transaksi.keterangan,onChanged: (val) {
                                            transaksi.keterangan = val;
                                          }), 'Keterangan', 2),
                                           _buildSize(Text(transaksi.sender), 'Penginput', 4),
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
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ));
                  });
            });
  }
}
