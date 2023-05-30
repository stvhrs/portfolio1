import 'package:flutter/material.dart';
import 'package:cahaya/transaksi_lain/delete_pendaptan.dart';
import 'package:cahaya/transaksi_lain/edit_pendapta.dart';
import 'package:cahaya/transaksi_lain/tambah_pendaptan.dart';
import 'package:cahaya/transaksi_lain/view_pendaptan.dart';
import 'package:cahaya/helper/custompaint.dart';
import 'package:cahaya/helper/format_tanggal.dart';
import 'package:cahaya/helper/rupiah_format.dart';

import 'package:cahaya/models/mutasi_saldo.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

import '../models/history_saldo2.dart';
import '../print_dynamic.dart';
import '../services/service.dart';

class CashFlow extends StatefulWidget {
  const CashFlow({super.key});

  @override
  State<CashFlow> createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
      late List<MutasiSaldo> listTransaksi;

 
  bool loading = true;
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
    listTransaksi = await Service.getAllMutasiSaldo();
if (!mounted) return;
    Provider.of<ProviderData>(context, listen: false)
        .setData([],[], false, [], [], [], [], listTransaksi);
loading = false;

    setState(() {});

   
  }
  @override
  void initState() {
        if (mounted){ initData();}
   
 
  

    super.initState();
  }


  final children = <int, Widget>{
    0: const Text('Masuk', style: TextStyle(fontFamily: 'Nunito')),
    1: const Text('Keluar', style: TextStyle(fontFamily: 'Nunito')),
  };

  @override
  Widget build(BuildContext context) {
    return  loading==true
        ? Center(
            child: CustomPaints(),
          )
        : Consumer<ProviderData>(builder: (context, c, h) {
                List<MutasiSaldo> listMutasi = [];
          ;
               
              
                  for (var element in c.listMutasiSaldo) {
                    if (!element.pendapatan) {
                      listMutasi.add(element);
                    }
                  }       listMutasi.sort((a, b) => DateTime.parse(b.tanggal)
          .compareTo(DateTime.parse(a.tanggal)));
                return Scaffold(
                body:  Center(
                  child: Container(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
          decoration: BoxDecoration(
              border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 10,
                    strokeAlign: StrokeAlign.center),
              color: const Color.fromRGBO(244, 244, 252,  1),
              borderRadius: BorderRadius.circular(10)),
          width:double.infinity,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: const Text(
                    'Pengeluaran',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
              ),
             
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  [
                                          const Spacer(),Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.print,
          color: Colors.white,
        ),
        label: Text(
          "Print Pengeluaran",
          style: TextStyle(color: Colors.white),
        ),
            onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrintDynamic( listMutasi.map((e) => HistorySaldo2("Nota Pengeluran", e.keterangan,
                 e.nota, e.harga, e.tanggal, )).toList()),
              ));
            }),
                    ),
                                           TambahPendapatan( false)
                                        ]
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
                          )), Expanded(
                          flex: 3,
                          child: Text(
                              'Nomor Nota',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          flex: 3,
                          child: Text('Keterangan',
                              style: Theme.of(context).textTheme.displayMedium)),
                     Expanded(
                          flex: 2,
                          child: Text(
                              'Harga',
                              style: Theme.of(context).textTheme.displayMedium)),
                              
                      Expanded(
                          flex: 1,
                          child: Text('Aksi',
                              style: Theme.of(context).textTheme.displayMedium))
                    ],
                  ),
              ),
              
               SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                              itemCount: listMutasi.length,
                              itemBuilder: (context, index) {
                                return InkWell(
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
                                                listMutasi[index].tanggal))),Expanded(
                                            flex: 3,
                                            child:
                                                Text(listMutasi[index].nota)),
                                        Expanded(
                                            flex: 3,
                                            child:
                                                Text(listMutasi[index].keterangan)),
                                       Expanded(
                                                                        flex: 2,
                                                                        child: Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(listMutasi[index].harga))
                      ]))), 
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                EditPendaptan(
                                                    listMutasi[index]),
                                                // ViewPendapatan(
                                                //     listMutasi[index]),
                                                Provider.of<ProviderData>(context,
                                                            listen: false)
                                                        .isOwner
                                                    ? DeletePendaptan(
                                                        listMutasi[index])
                                                    : const SizedBox()
                                              ],
                                            )),
                                        // Expanded(
                                        //     flex: 1,
                                        //     child: currentSegment == 1
                                        //         ? JualEdit(listMutasi[index])
                                        //         : BeliEdit(
                                        //             listMutasi[index]))
                                      ],
                                    ),
                                  ),
                                );
                              }))
                      
                                   
                                  
                              
                            
            
            ],
          )),
                ),
        );
  }

        );}}