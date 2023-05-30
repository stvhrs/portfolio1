import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cahaya/helper/format_tanggal.dart';
import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/jualbeli/beli/beli_add.dart';
import 'package:cahaya/jualbeli/beli/beli_edit.dart';
import 'package:cahaya/jualbeli/jual/jual_add.dart';
import 'package:cahaya/jualbeli/jual/jual_edit.dart';
import 'package:cahaya/models/history_saldo2.dart';
import 'package:cahaya/models/jual_beli_mobil.dart';
import 'package:cahaya/print_dynamic.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../models/history_saldo.dart';
import '../services/service.dart';
import 'package:cahaya/helper/custompaint.dart';
class JualBeli extends StatefulWidget {
  const JualBeli({super.key});

  @override
  State<JualBeli> createState() => _JualBeliState();
}

class _JualBeliState extends State<JualBeli> {
    late List<JualBeliMobil> listTransaksi;

 
  bool loading = true;
  initData() async {

    listTransaksi = await Service.getAlljualBeli();
if (!mounted) return;
    Provider.of<ProviderData>(context, listen: false)
        .setData([],[], false, [], [], [], listTransaksi, []);

loading = false;

    setState(() {});
    
  }
  @override
  void initState() {
    if (mounted){ initData();}
  
    super.initState();
  }
  int currentSegment = 0;
  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment = newValue!;
    });
  }

  final children = <int, Widget>{
    0: const Text('Beli',style: TextStyle(fontFamily: 'Nunito')),
    1: const Text('Jual',style: TextStyle(fontFamily: 'Nunito')),
  };
  @override
  Widget build(BuildContext context) {
     List<JualBeliMobil> listMutasi=[];
                List<JualBeliMobil> listMutasi2=[]; 
    return  loading==true
        ? Center(
            child: CustomPaints(),
          )
        : Scaffold(floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.print,
              color: Colors.white,
            ),
            onPressed: () {
              
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrintDynamic(currentSegment==0? listMutasi.map((e) => HistorySaldo2("Beli Mobil", e.keterangan, e.mobil, e.harga, e.tanggal, )).toList():listMutasi2.map((e) => HistorySaldo2("Beli Mobil", e.keterangan, e.mobil, e.harga, e.tanggal, )).toList()),
              ));
            }),
                body: 
          Container(     width:double.infinity,
          padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 10,
                  strokeAlign: StrokeAlign.center),
              color: const Color.fromRGBO(244, 244, 252,  1),
              borderRadius: BorderRadius.circular(10)),
     
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.only(
                    right: 30, left: 30, bottom: 10, ),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: const Text(
                  'Jual Beli Unit',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CupertinoSlidingSegmentedControl<int>(
                        children: children,
                        onValueChanged: onValueChanged,
                        groupValue: currentSegment,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ? [
                                      const Spacer(),
                                      currentSegment == 0 ? BeliAdd() : JualAdd(),
                                    ]
                                  : []),
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Text(
                          'Tanggal',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 3,
                        child: Text('Mobil',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 3,
                        child: Text('Harga',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 6,
                        child: Text('Keterangan',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 1,
                        child: Text('Aksi',
                            style: Theme.of(context).textTheme.displayMedium))
                  ],
                ),
              ),
              Consumer<ProviderData>(builder: (context, c, h) {
                  
                   
                        if(currentSegment==0){
                          for (var element in c.listJualBeliMobil) {
                            if(element.beli){  listMutasi.add(element);}
                          
                          }
                        }
                        if(currentSegment==1){
                          for (var element in c.listJualBeliMobil) {
                            if(!element.beli){  listMutasi2.add(element);}
                          
                          }
                        } listMutasi.sort((a, b) => DateTime.parse(b.tanggal)
                  .compareTo(DateTime.parse(a.tanggal)));
                       listMutasi2.sort((a, b) => DateTime.parse(b.tanggal)
                  .compareTo(DateTime.parse(a.tanggal)));
                return currentSegment==0?
                 SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: listMutasi.length,
                      itemBuilder: (context, index) => InkWell(
                              child: Container(
                                color: index.isEven
                                    ?  Colors.white
                                    : Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(FormatTanggal.formatTanggal(
                                           listMutasi[index].tanggal))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                           listMutasi[index].mobil)),
                                    Expanded(
                                        flex: 3,
                                        child: Text(Rupiah.format(
                                           listMutasi[index].harga))),
                                    Expanded(
                                        flex: 6,
                                        child: Text(listMutasi[index]
                                            .keterangan)),
                                    Expanded(
                                        flex: 1,
                                        child: BeliEdit(
                                               listMutasi[index]))
                                  ],
                                ),
                              ),
                            ))):SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: listMutasi2.length,
                      itemBuilder: (context, index) => InkWell(
                              child: Container(
                                color: index.isEven
                                    ?  Colors.white
                                    : Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Text(FormatTanggal.formatTanggal(
                                           listMutasi2[index].tanggal))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                           listMutasi2[index].mobil)),
                                    Expanded(
                                        flex: 3,
                                        child: Text(Rupiah.format(
                                           listMutasi2[index].harga))),
                                    Expanded(
                                        flex: 6,
                                        child: Text(listMutasi2[index]
                                            .keterangan)),
                                    Expanded(
                                        flex: 1,
                                        child: JualEdit(
                                               listMutasi2[index]))
                                  ],
                                ),
                              ),
                            )));
                          
              })
            ],
          )),
        );
  }
}
