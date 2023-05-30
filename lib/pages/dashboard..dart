import 'package:flutter/material.dart';

import 'package:cahaya/dashboard/ranguman_tile.dart';
import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/logout.dart';
import 'package:provider/provider.dart';

import '../providerData/providerData.dart';
import 'package:d_chart/d_chart.dart';

class DashBoardPage extends StatefulWidget {
  final String username;
  const DashBoardPage(this.username);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List<String> list = <String>[
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  String jumlahSupir = '';
  String jumlahMobil = '';
  String jumlahTransaksiBulanini = '';
  String saldoSaatIni = '';
  List<Map<String, dynamic>> grafik = [];
  List<int> tigaPuluh1 = [];
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false).startMutasi = null;
    Provider.of<ProviderData>(context, listen: false).endMutasi = null;

    Provider.of<ProviderData>(context, listen: false).start = null;
    Provider.of<ProviderData>(context, listen: false).end = null;
    Provider.of<ProviderData>(context, listen: false).searchsupir = '';
    Provider.of<ProviderData>(context, listen: false).searchtujuan = '';
    Provider.of<ProviderData>(context, listen: false).searchmobile = '';
    // Provider.of<ProviderData>(context, listen: false).searchTransaksi("",false);
    Provider.of<ProviderData>(context, listen: false).calculateSaldo();
    //  Provider.of<ProviderData>(context, listen: false).searchHistorySaldo();
    Provider.of<ProviderData>(context, listen: false).calculateMutasi();
    jumlahSupir = Provider.of<ProviderData>(context, listen: false)
        .listSupir.where((element) => element.delted==false)
        .length
        .toString();
    jumlahMobil = Provider.of<ProviderData>(context, listen: false)
        .backupListMobil.where((element) => element.terjual==false).toList()
        .length
        .toString();
    jumlahTransaksiBulanini = Provider.of<ProviderData>(context, listen: false)
        .backupTransaksi
        .where((element) =>
            DateTime.parse(element.tanggalBerangkat).month ==
                DateTime.now().month &&
            DateTime.parse(element.tanggalBerangkat).year ==
                DateTime.now().year)
        .toList()
        .length
        .toString();
    saldoSaatIni = Rupiah.format(
        Provider.of<ProviderData>(context, listen: false).totalSaldo);

    super.initState();
  }
double totalSisaBulanIni=0;
  @override
  void didChangeDependencies() {
    for (var element in Provider.of<ProviderData>(context,listen: false).listTransaksi.where((element) =>
    
    DateTime.parse( element.tanggalBerangkat).month==DateTime.now().month&&DateTime.parse( element.tanggalBerangkat).year==DateTime.now().year)) {
      totalSisaBulanIni+=element.sisa;
    }
    for (var element in Provider.of<ProviderData>(context, listen: false)
        .listHistorySaldo.reversed.toList()
        .where((element) =>
            DateTime.parse(element.tanggal).month == DateTime.now().month &&
            DateTime.parse(element.tanggal).year == DateTime.now().year)
        .toList()) {
      if (tigaPuluh1.contains(DateTime.parse(element.tanggal).day)) {
      } else {
        tigaPuluh1.add(DateTime.parse(element.tanggal).day);
        grafik.add({
          'domain': DateTime.parse(element.tanggal).day,
          'measure': element.sisaSaldo
        });
      }
     
    }
    if(grafik.isNotEmpty){
 grafik.last['measure']=Provider.of<ProviderData>(context,listen: false).totalSaldo;
     
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height * 0.06,
          child: Row(
            children: [
            
            
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      Provider.of<ProviderData>(context, listen: false).isOwner
                          ? 'images/boss.png'
                          : 'images/admin.png',

                      // color: Colors.white,
                    ),
                  ),
                  Text(
                    Provider.of<ProviderData>(context, listen: false).isOwner
                        ? 'Owner : ${widget.username}'
                        : 'Admin : ${widget.username}',
                    style: const TextStyle(
                        fontFamily: 'Nunito', fontWeight: FontWeight.bold,fontSize: 14),
                  ),
                  // Spacer(),
               
                ],
              ),  const Spacer(),   const VerticalDivider(), const VerticalDivider(),
              Logout()
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Rangkuman(Colors.green,Rupiah.format(totalSisaBulanIni) , 'Total Sisa Bulan ini',
                      Icons.attach_money_rounded),
                  Rangkuman(Colors.blue, jumlahMobil, 'Jumlah Mobil',
                      Icons.fire_truck_rounded),
                  Rangkuman(Colors.orange, jumlahSupir, 'Jumlah Supir',
                      Icons.people_alt_rounded),
                  Rangkuman(Colors.brown, jumlahTransaksiBulanini,
                      'Ritase Bulan ini', Icons.currency_exchange_rounded),
                ],
              ),
            ],
          ),
        ),
      Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ?   Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Grafik  ',style: TextStyle(fontFamily: 'Nunito',fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  const Divider(height: 1,color: Colors.black,),
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: DChartLine(
                      areaColor: (lineData, index, id) => Colors.blue,
                      includePoints: true,
                      animate: true,
                      includeArea: true,
                      data: [
                        {
                          'id': 'Line',
                          'data': grafik,
                        },
                      ],
                      lineColor: (lineData, index, id) => Colors.green,
                    ),
                  ),
                ],
              ),
            
          ),
        ):SizedBox(),
      ],
    );
  }
}
