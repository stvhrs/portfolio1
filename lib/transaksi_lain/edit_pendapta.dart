import 'dart:async';

import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/mutasi_saldo.dart';
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

class EditPendaptan extends StatefulWidget {
  final MutasiSaldo perbaikan;
  const EditPendaptan(this.perbaikan);
  @override
  State<EditPendaptan> createState() => _EditPendaptanState();
}

class _EditPendaptanState extends State<EditPendaptan> {
  List<String> listMobil = [];

 

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final TextEditingController mobilCont = TextEditingController();
  
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
 FocusNode fd = FocusNode();
  @override
  Widget build(BuildContext context) {
      
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
                         Text(
                          widget.perbaikan.pendapatan?"Edit Pemasukan":"'Edit Pengeluaran",
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
                                                Picker(lastDate: DateTime.now(),fd: fd,
                                            height: 60,
                                            initialDate: DateTime.parse(
                                                widget.perbaikan.tanggal),
                                            dateformat: 'dd/MM/yyyy',
                                            onChange: (value) {
                                              if (value != null) {
                                                widget.perbaikan.tanggal =
                                                    value.toIso8601String();
                                              }
                                            },
                                          ),
                                          'Tanggal',
                                          1),
                                      _buildSize(
                                          TextFormField(
                                style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                            initialValue: widget.perbaikan.keterangan,
                                            onChanged: (va) {
                                              widget.perbaikan.keterangan = va;
                                            },
                                          ),
                                          'Keterangan',
                                          1),
                                     
                                      _buildSize(
                                          TextFormField(
                                style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                            initialValue:
                                                Rupiah.format(widget.perbaikan.harga),
                                            onChanged: (va) {
                                              widget.perbaikan.harga =
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
                                style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                            initialValue: widget.perbaikan.nota,
                                            onChanged: (va) {
                                              widget.perbaikan.nota = va;
                                            },
                                          ),
                                          'Nomor Nota',
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
                                        if (widget.perbaikan.harga == 0 ||
                                            widget.perbaikan.keterangan.isEmpty
                                          ) {
                                          _btnController.error();
                                          await Future.delayed(
                                              const Duration(seconds: 1));
                                          _btnController.reset();
                                          return;
                                        }
                            
                                 
                                
                                                 var data = await Service.updateMutasi(
                                                      {
        "id_mutasi": widget.perbaikan.id,
        "pendapatan_mutasi":  widget.perbaikan.pendapatan?"true":"false",
        "tanggal_mutasi": widget.perbaikan.tanggal,
        "keterangan_mutasi": widget.perbaikan.keterangan,
        "total_mutasi": widget.perbaikan.harga.toString(),
        "nota":widget.perbaikan.nota
    },);
                                
                            
                                                    if (data != null) {
                                                      Provider.of<ProviderData>(context, listen: false)
                                .updateMutasi(data);  _btnController.success();
                                                    }else{
                                                      _btnController.error();
                                                     await Future.delayed(
                                            const Duration(seconds: 1), () {
                                           _btnController.reset();
                                        });
                                        return;
                                                    }
                                        
                                        
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
