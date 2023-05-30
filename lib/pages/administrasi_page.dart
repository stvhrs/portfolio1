import 'package:flutter/material.dart';

import 'package:cahaya/administrasi/admin_delete.dart';
import 'package:cahaya/administrasi/admin_edit.dart';
import 'package:cahaya/helper/format_tanggal.dart';
import 'package:cahaya/helper/rupiah_format.dart';

import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/services/service.dart';
import 'package:provider/provider.dart';
import 'package:cahaya/helper/custompaint.dart';
import '../Perbaikan/Perbaikan_add.dart';
import '../models/history_saldo.dart';
import '../models/history_saldo2.dart';
import '../models/perbaikan.dart';
import '../print_dynamic.dart';


class AdministrasiPage extends StatefulWidget {
  const AdministrasiPage({super.key});

  @override
  State<AdministrasiPage> createState() => _AdministrasiPageState();
}

class _AdministrasiPageState extends State<AdministrasiPage> {
      late List<Perbaikan> listTransaksi;

 
  bool loading = true;
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
    listTransaksi = await Service.getAllPerbaikan();
if (!mounted) return;
    Provider.of<ProviderData>(context, listen: false)
        .setData([],[], false, [], [], listTransaksi, [], []);
loading = false;

    setState(() {});

    
  }
 
  

 
  @override
  void initState() {
        if (mounted){ initData();}
                          Provider.of<ProviderData>(context, listen: false)
                            .searchperbaikan('',false);
                                Provider.of<ProviderData>(context, listen: false).searchMobil('', false);
                            
    super.initState();
  }
List<Perbaikan> data=[];
  @override
  Widget build(BuildContext context) {
    return  loading==true
        ? Center(
            child: CustomPaints(),
          )
        : Consumer<ProviderData>(builder: (context, c, h) {
         data=c. listPerbaikan.where((element) => element.adminitrasi==true).toList();
  data.sort((a, b) => DateTime.parse(b.tanggal)
          .compareTo(DateTime.parse(a.tanggal)));
              // if (_search != '') {
              //   // c.listSupir.clear();
              //   for (var element in c.listSupir) {
              //     if (element.nama_supir
              //         .toLowerCase()
              //         .startsWith(_search.toLowerCase())) {
              //       c.listSupir.add(element);
              //     }
              //   }
              // } else {
              //   c.listSupir = c.listSupir;
              // }

              return Scaffold(
                body:  Center(
                  child: Container(width:double.infinity,
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
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.only(
                      right: 30, left: 30, bottom: 10, top: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: const Text(
                    'Administrasi',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                            ),
                            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        height: MediaQuery.of(context).size.height / 20,
                        child: TextFormField(
                                  style: const TextStyle(fontSize:13),
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(hintText: 'Cari'),
                          onChanged: (val) {
                            Provider.of<ProviderData>(context, listen: false)
                                .searchperbaikan(val.toLowerCase(),true);
                          },
                        ),
                      ),
                    ),
                    const Expanded(flex: 4, child: SizedBox()),Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.print,
          color: Colors.white,
        ),
        label: Text(
          "Print Administrasi",
          style: TextStyle(color: Colors.white),
        ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrintDynamic(data.map((e) => HistorySaldo2("Administrasi", e.keterangan, e.mobil, e.harga, e.tanggal, )).toList()),
              ));
            }),
                    ),
                    PerbaikanAdd(false)
                  ],
                            ),
                            Container(
                  color: Theme.of(context).primaryColor,    margin: const EdgeInsets.only(top: 15),
                  padding:
                      const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 11,
                          child: Text(
                            'Tanggal',
                            style: Theme.of(context).textTheme.displayMedium,
                          )),
                      Expanded(
                          flex: 11,
                          child: Text('No Pol',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          flex: 11,
                          child: Text('Jenis',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          flex: 11,
                          child: Text('Nominal',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                          flex: 20,
                          child: Text('Keterangan',
                              style: Theme.of(context).textTheme.displayMedium)),
                      Expanded(
                        flex: 4,
                        child: Text('Aksi',
                            style: Theme.of(context).textTheme.displayMedium),
                      )
                    ],
                  ),
                            ),
                             SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        itemCount:data.length,
                        itemBuilder: (context, index) => InkWell(
                          child: Container(
                            color: index.isEven
                                ?  Colors.white
                                : Colors.grey.shade200,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 11,
                                    child: Text(FormatTanggal.formatTanggal(
                                        data. toList()[index].tanggal))),
                                Expanded(
                                    flex: 11,
                                    child: Text(data. toList()[index].mobil)),
                                Expanded(
                                    flex: 11,
                                    child: Text(data. toList()[index].jenis)),
                                 Expanded(
                                                                        flex: 11,
                                                                        child: Container(
                  margin: EdgeInsets.only(right: 60),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(data[index].harga))
                      ]))),
                                Expanded(
                                    flex: 20,
                                    child: Text(data. toList()[index].keterangan)),
                                Expanded(
                                    flex: 2,
                                    child: Provider.of<ProviderData>(context)
                                            .isOwner
                                        ? AdministrasiDelete(data. toList()[index])
                                        : const SizedBox()),
                                Expanded(
                                    flex: 2,
                                    child: AdministrasiEdit(data. toList()[index]))
                              ],
                            ),
                          ),
                        ),
                      ))])),
                ),
              );
            });
          
        
  }
}
