import 'dart:async';

import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/perbaikan.dart';

import 'package:cahaya/providerData/providerData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cahaya/services/service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:web_date_picker/web_date_picker.dart';

import '../helper/dropdown.dart';
import '../helper/input_currency.dart';
import '../transaksi/datepicer.dart';

class PerbaikanEdit extends StatefulWidget {
  final Perbaikan perbaikan;
  const PerbaikanEdit(this.perbaikan);
  @override
  State<PerbaikanEdit> createState() => _PerbaikanEditState();
}

class _PerbaikanEditState extends State<PerbaikanEdit> {
  List<String> listMobil = [];

 

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final TextEditingController mobilCont = TextEditingController();
  late Perbaikan perbaikan;
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
              Expanded(flex: 2, child:SizedBox(height: 36,child: widget)),
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

  @override
  Widget build(BuildContext context) {
        perbaikan=widget.perbaikan;
    mobilCont.text = widget.perbaikan.mobil;
    listMobil=Provider.of<ProviderData>(context, listen: false)
        .listMobil.where((element) => element.terjual==false).map((e) => e.nama_mobil).toList();

    return IconButton(
        icon: const Icon(
          Icons.edit,
          color: Colors.green,
        ),
       
        
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
                          'Edit Perbaikan',
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:  SingleChildScrollView(
                              child: Column(
                                children: [
                                 
                                      _buildSize(
                                                Picker(lastDate: DateTime.now(),
                                            height: 60,fd: FocusNode(),
                                            initialDate: DateTime.parse(
                                                widget.perbaikan.tanggal),
                                            dateformat: 'dd/MM/yyyy',
                                            onChange: (value) {
                                              if (value != null) {
                                                perbaikan.tanggal =
                                                    value.toIso8601String();
                                              }
                                            },
                                          ),
                                          'Tanggal',
                                          1),   _buildSize2(
                                          DropDownField(
                                            controller: mobilCont,
                                            onValueChanged: (val) {
                                              perbaikan.mobil = val;
                                              perbaikan.id_mobil=Provider.of<ProviderData>(context,listen: false).listMobil.firstWhere((element) => element.nama_mobil==val).id;
                            
                                            },
                                            items: listMobil,
                                          ),
                                          'Pilih No Pol',
                                          1), 
                                      _buildSize(
                                          TextFormField(
                                style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                            initialValue: perbaikan.jenis,
                                            onChanged: (va) {
                                              perbaikan.jenis = va;
                                            },
                                          ),
                                          'Jenis Perbaikan',
                                          1),
                                   
                                      _buildSize(
                                          TextFormField(
                                style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                            initialValue:
                                                Rupiah.format(perbaikan.harga),
                                            onChanged: (va) {
                                              perbaikan.harga =
                                                  Rupiah.parse(va);
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              CurrencyInputFormatter()
                                            ],
                                          ),
                                          'Nominal Perbaikan',
                                          1),
                                  
                                
                                      _buildSize(
                                          TextFormField(
                                style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                            initialValue: perbaikan.keterangan,
                                            onChanged: (va) {
                                              perbaikan.keterangan = va;
                                            },
                                          ),
                                          'Keterangan',
                                          2),
                                   
                                
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:  Container(margin: const EdgeInsets.only(top: 10),
                                    child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        if (perbaikan.harga == 0 ||
                                            perbaikan.jenis.isEmpty ||
                                            perbaikan.mobil.isEmpty) {
                                          _btnController.error();
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          _btnController.reset();
                                          return;
                                        }
                            
                                 
                                
                                                 var data = await Service.updatePerbaikan(
                                                       {
                                   
                                  "id_perbaikan":perbaikan.id,
                                    "id_mobil": perbaikan.id_mobil,
                                    "plat_mobil": perbaikan.mobil,
                                    "ket_mobil":perbaikan.keterangan,
                                    "jenis_p": perbaikan.jenis,
                                    "harga_p": perbaikan.harga.toString(),
                                    "ket_p": perbaikan.keterangan,
                                    "tgl_p": perbaikan.tanggal
                                });
                                
                            
                                                    if (data != null) {
                                                      Provider.of<ProviderData>(context, listen: false)
                                .updatePerbaikan(data);
                                                    }else{
                                                      _btnController.error();
                                                    }
                                          _btnController.success();
                                        
                                        await Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: const Text('Edit',
                                          style: TextStyle(color: Colors.white)),
                                    ),
                                  ])
                              ))],
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
