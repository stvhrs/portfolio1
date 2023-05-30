import 'dart:async';

import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/jual_beli_mobil.dart';
import 'package:cahaya/models/mobil.dart';

import 'package:cahaya/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cahaya/services/service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../../helper/input_currency.dart';
import '../../transaksi/datepicer.dart';

class BeliAdd extends StatefulWidget {
  @override
  State<BeliAdd> createState() => _BeliAddState();
}

class _BeliAddState extends State<BeliAdd> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late JualBeliMobil jualBeliMobil;
  TextStyle small = const TextStyle(fontSize: 13.5);
  Widget _buildSize(widget, String ket, int flex) {
    return Container(
        margin: const EdgeInsets.only(bottom: 7, top: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '$ket :',
                style: const TextStyle(fontSize: 13.5),
              ),
            ),
            Expanded(flex: 2, child: SizedBox(height: 36, child: widget)),
          ],
        ));
  }

  Widget _buildSize2(widget, String ket, int flex) {
    return Container(
        margin: const EdgeInsets.only(bottom: 7, top: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '$ket :',
                style: const TextStyle(fontSize: 13.5),
              ),
            ),
            Expanded(flex: 2, child: widget),
          ],
        ));
  }
 FocusNode fd = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10))),
        onPressed: () {
          jualBeliMobil = JualBeliMobil.fromMap({
            'id_jb': '0',
            'id_mobil': '0',
            'plat_mobil': '0',
            'ket_mobil': '0',
            'harga_jb': "0",
            'tgl_jb': DateTime.now().toIso8601String(),
            'jualOrBeli': "true",
            'ket_jb': 'keterangan'
          });

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
                          'Beli Unit',
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
                          builder:
                              (BuildContext context, StateSetter setState) =>
                                  IntrinsicHeight(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 20, right: 20, top: 5),
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('images/jb.png',width: 100,),
                                  ),
                                  _buildSize(
                                       Picker(
                                        lastDate: DateTime.now(),fd: fd,
                                        height: 60,
                                        initialDate: DateTime.now(),
                                        dateformat: 'dd/MM/yyyy',
                                        onChange: (value) {
                                          if (value != null) {
                                            jualBeliMobil.tanggal =
                                                value.toIso8601String();
                                          }
                                        },
                                      ),
                                      'Tanggal',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          jualBeliMobil.mobil = va;
                                        },
                                      ),
                                      'Mobil',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          jualBeliMobil.ketMobil = va;
                                        },
                                      ),
                                      'Jenis Mobil',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          jualBeliMobil.harga =
                                              Rupiah.parse(va);
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          CurrencyInputFormatter()
                                        ],
                                      ),
                                      'Harga',
                                      1),
                                  _buildSize(
                                      TextFormField(
                                        style: const TextStyle(fontSize: 13),
                                        textInputAction: TextInputAction.next,
                                        onChanged: (va) {
                                          jualBeliMobil.keterangan = va;
                                        },
                                      ),
                                      'Keterangan',
                                      2),
                                  Container(margin: const EdgeInsets.only(top: 30),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [RoundedLoadingButton(width: 120,color: Colors.red,controller:
                                         RoundedLoadingButtonController(), onPressed: (){
                                          Navigator.of(context).pop();
                                         }, child: const Text('Batal',
                                                style: TextStyle(color: Colors.white))),
                                          RoundedLoadingButton(width: 120,
                                            color: Colors.green,
                                            elevation: 10,
                                            successColor: Colors.green,
                                            errorColor: Colors.red,
                                            controller: _btnController,
                                            onPressed: () async {
                                              if (jualBeliMobil.harga == 0 ||
                                                  jualBeliMobil.tanggal.isEmpty ||
                                                  jualBeliMobil.mobil.isEmpty) {
                                                _btnController.error();
                                                await Future.delayed(
                                                    const Duration(seconds: 1));
                                                _btnController.reset();
                                                return;
                                              }
                                    
                                              var data = await Service.postJB({
                                                'plat_mobil': jualBeliMobil.mobil,
                                                'ket_mobil': jualBeliMobil.ketMobil,
                                                'harga_jb':
                                                    jualBeliMobil.harga.toString(),
                                                'tgl_jb': jualBeliMobil.tanggal,
                                                'jualOrBeli': "true",
                                                'ket_jb': jualBeliMobil.ketMobil
                                              });
                                    
                                              if (data != null) {
                                                Provider.of<ProviderData>(context,
                                                        listen: false)
                                                    .addMobil(Mobil.fromMap({
                                                  'id_mobil': data.id_mobil,
                                                  'plat_mobil': data.mobil,
                                                  "ket_mobil": data.ketMobil
                                                }, []));
                                                data.mobil = jualBeliMobil.mobil;
                                                data.ketMobil = jualBeliMobil.ketMobil;
                                                Provider.of<ProviderData>(context,
                                                        listen: false)
                                                    .addJualBeliMobil(data);
                                              } else {
                                                _btnController.error();
                                                await Future.delayed(
                                                    const Duration(seconds: 1), () {});
                                                _btnController.reset();
                                              }
                                    
                                              _btnController.success();
                                    
                                              await Future.delayed(
                                                  const Duration(seconds: 1), () {
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            child: const Text('Beli',
                                                style: TextStyle(color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  
                                ]),
                              ),
                            ),
                          ),
                        )));
              });
        },
        child: const Text(
          'Beli',
          style: TextStyle(color: Colors.white),
        ));
  }
}
