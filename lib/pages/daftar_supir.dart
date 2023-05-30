import 'package:flutter/material.dart';
import 'package:cahaya/models/supir.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/services/service.dart';
import 'package:cahaya/supir/supir_tile.dart';
import 'package:cahaya/supir/tambah_supir.dart';
import 'package:provider/provider.dart';
import 'package:cahaya/helper/custompaint.dart';

import '../models/history_saldo2.dart';
import '../print_unitku.dart';
class DaftarSupir extends StatefulWidget {
  const DaftarSupir({super.key});

  @override
  State<DaftarSupir> createState() => _DaftarSupirState();
}

class _DaftarSupirState extends State<DaftarSupir> {
    late List<Supir> listTransaksi;

 
  bool loading = true;
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
    listTransaksi = await Service.getAllSupir();
if (!mounted) return;
    Provider.of<ProviderData>(context, listen: false)
        .setData([],[], false, [], listTransaksi, [], [], []);

    
loading = false;

    setState(() {});
  }
  @override
  void initState() {
    if (mounted){   initData();}
   
     Provider.of<ProviderData>(context, listen: false).searchMobil('', false);
    Provider.of<ProviderData>(context, listen: false).searchSupir('', false);
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return  loading==true
        ? Center(
            child: CustomPaints(),
          )
        : 
            Consumer<ProviderData>(builder: (context, c, h) {
             List<Supir> data=c.listSupir.reversed.toList() .where((element) => element.delted==false) .toList().reversed.toList();
              return Scaffold(
                body: SizedBox(
                  
                    child: Container(
                      padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
                      decoration: BoxDecoration(
                          border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 10,
                  strokeAlign: StrokeAlign.center),
                          color: const Color.fromRGBO(244, 244, 252, 1),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.only(
                    right: 30, left: 30, bottom: 10, top: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: const Text(
                  'Daftar Driver',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nunito',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                          ),
                          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 13),
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(hintText: 'Cari'),
                        onChanged: (val) {
                          Provider.of<ProviderData>(context, listen: false)
                              .searchSupir(val.toLowerCase(), true);
                        },
                      ),
                    ),
                  ),
                  const Expanded(flex: 4, child: SizedBox()),Expanded(flex: 4,child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton.icon(
        icon: const Icon(
          Icons.print,
          color: Colors.white,
        ),
        label: Text(
          "Print Driver",
          style: TextStyle(color: Colors.white),
        ),
            onPressed: () {
              
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PrintUnitKu( data.map((e) => HistorySaldo2("Daftar Driver", e.nama_supir,
                 e.nohp_supir, 0 ,"", )).toList()),
              ));
            }),
                  ),
                  TambahSupir()
                ],
                          ),
                          Container(
                margin: const EdgeInsets.only(top: 15),
                color: Theme.of(context).colorScheme.primary,
                padding:
                    const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 11,
                        child: Text(
                          'Nama',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                    Expanded(
                        flex: 11,
                        child: Text('Nomor Hp',
                            style: Theme.of(context).textTheme.displayMedium)),
                    Expanded(
                        flex: 3,
                        child: Text(' Aksi',
                            style: Theme.of(context).textTheme.displayMedium))
                  ],
                ),
                          ),
                        SizedBox( height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return
                           
                              
                             SupirTile(data
                                           [index],index);;},
                          ),
                        ),
                      ],
                    )),
          )
              );
            });
         
  }
}
