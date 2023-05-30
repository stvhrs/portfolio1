import 'package:flutter/material.dart';
import 'package:cahaya/helper/custompaint.dart';
import 'package:cahaya/hp_transaksi_add.dart';
import 'package:cahaya/hp_transaksi_tile.dart';
import 'package:cahaya/logout_hp.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/transaksi/transaksi_tile.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:cahaya/models/jual_beli_mobil.dart';



import 'package:cahaya/services/service.dart';


import 'package:shared_preferences/shared_preferences.dart';


import 'models/mobil.dart';
import 'models/mutasi_saldo.dart';
import 'models/perbaikan.dart';
import 'models/supir.dart';
import 'models/transaksi.dart';
import 'models/user.dart';

class DashBoardHp extends StatefulWidget {
  const DashBoardHp({super.key});

  @override
  State<DashBoardHp> createState() => _DashBoardHpState();
}

class _DashBoardHpState extends State<DashBoardHp> {
  PageController page = PageController();


  late List<Transaksi> listTransaksi;
  late List<Supir> listSupir;
  late List<Mobil> listMobil;
  late List<Perbaikan> listPerbaikan;
  late List<JualBeliMobil> listJualBeliMobil;
  late List<MutasiSaldo> listMutasiSaldo;
  late List<User> listUser;
  bool loading = true;
  String test = '';
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
listUser=await Service.getUser();
    listTransaksi = await Service.getAllTransaksi();
    listSupir = await Service.getAllSupir();
    listPerbaikan = await Service.getAllPerbaikan();

    listJualBeliMobil = await Service.getAlljualBeli();
    listMobil = await Service.getAllMobil(listPerbaikan);
    listMutasiSaldo=await Service.getAllMutasiSaldo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');
    if (jsonDecode(data!)['status'] == 'owner') {
    
      Provider.of<ProviderData>(context, listen: false).owner();
    } else {
    
      Provider.of<ProviderData>(context, listen: false).admin();
    }
 Provider.of<ProviderData>(context, listen: false).user = User.fromMap( jsonDecode(data));
    Provider.of<ProviderData>(context, listen: false).setData(listUser,listTransaksi,
        false, listMobil, listSupir, listPerbaikan, listJualBeliMobil,listMutasiSaldo);
    
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
        if (mounted){ initData();}

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return loading
        ?  Center(
            child: CustomPaints(),
          )
        : Consumer<ProviderData>(builder: (context, prov, _) {
            return Scaffold(
                appBar: AppBar(  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  title: const Text('Riwayat Transaksi',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nunito',
                          letterSpacing: 1.1)),
                  leading: HpLogout()
                ),
                
                backgroundColor: Colors.grey.shade300,
                floatingActionButton: HpTransaksiAdd(),
                body:  SingleChildScrollView(scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(top: 0, ),
                    child: Container(width: MediaQuery.of(context).size.height*1.5,
                      child: 
                          Column(mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Container(padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Tanggal',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'No Pol',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Driver',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Tujuan',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Keterangan',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Tarif',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Keluar',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: Text(
                                          'Sisa',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )),
                                   
                                  ],
                                ),
                              ),
                              Expanded(
                                // height: MediaQuery.of(context).size.height * 0.7,
                                child: ListView.builder(shrinkWrap: true,
                                    itemCount: prov.listTransaksi.length,
                                    itemBuilder: (context, index) {
                                      var data=prov.listTransaksi;
                                       data.sort((a, b) => DateTime.parse(b.tanggalBerangkat)
          .compareTo(DateTime.parse(a.tanggalBerangkat)));
                                      return
                                        HpTransaksiTile(prov.listTransaksi[index], index + 1);}),
                              ),
                            ],
                          ),
                     
                    )));
          });
  }
}
