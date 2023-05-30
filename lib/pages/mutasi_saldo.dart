import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cahaya/helper/format_tanggal.dart';
import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/mutasiSaldo/mutasi_search.dart';
import 'package:cahaya/print3.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

class MutasiSaldoPage extends StatefulWidget {
  const MutasiSaldoPage({super.key});

  @override
  State<MutasiSaldoPage> createState() => _MutasiSaldoPageState();
}

class _MutasiSaldoPageState extends State<MutasiSaldoPage> {
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false).startMutasi = null;
    Provider.of<ProviderData>(context, listen: false).endMutasi = null;

    Provider.of<ProviderData>(context, listen: false).start = null;
    Provider.of<ProviderData>(context, listen: false).end = null;
    Provider.of<ProviderData>(context, listen: false).searchsupir = '';
    Provider.of<ProviderData>(context, listen: false).searchtujuan = '';
    Provider.of<ProviderData>(context, listen: false).searchmobile = '';
    
    Provider.of<ProviderData>(context, listen: false).searchMobil('', false);
    Provider.of<ProviderData>(context, listen: false).searchTransaksi("",false);

    Provider.of<ProviderData>(context, listen: false).searchperbaikan('',false);
    Provider.of<ProviderData>(context, listen: false).calculateSaldo();

    Provider.of<ProviderData>(context, listen: false).calculateMutasi();
    log('calucalte mutasi page');
 

  

    super.initState();
  }

  bool transaksi = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(
      builder: (context, value, child) => Scaffold(
        
        body: Container(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 15),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 10,
                    strokeAlign: StrokeAlign.center),
                color: const Color.fromRGBO(244, 244, 252,  1),
                borderRadius: BorderRadius.circular(10)),
            // width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
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
                    'Mutasi Saldo',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image.asset('images/search.png',
                    //                   height: 30),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SearchMutasi(),Spacer(),Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.print,
          color: Colors.white,
        ),
        label: Text(
          "Print Mutasi",
          style: TextStyle(color: Colors.white),
        ),
            onPressed: () {
               Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MutasiPrint(value.listHistorySaldo),
              ));
            }),
                    ),
                        Text(Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ? 'Saldo : ${Rupiah.format(value.totalSaldo)}':"",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    )),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 5,
                          child: Text(
                        'Tanggal',
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                      Expanded(flex: 5,
                          child: Text('Sumber',
                              style:
                                  Theme.of(context).textTheme.displayMedium)),
                      Expanded(flex: 5,
                          child: Text('Detail',
                              style:
                                  Theme.of(context).textTheme.displayMedium)),
                      Expanded(flex: 4,
                          child: Text('Nominal',
                              style:
                                  Theme.of(context).textTheme.displayMedium)),
                      Expanded(flex: 7,
                          child: Container(margin: EdgeInsets.only(right: 60),
                            child: Text(textAlign: TextAlign.right,'Riwayat Saldo',
                                style: Theme.of(context).textTheme.displayMedium),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount: value.listHistorySaldo.length,
                        itemBuilder: (context, index) => (InkWell(
                              child: Container(
                                color: index.isEven
                                    ?  Colors.white
                                    : Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15,top: 5,bottom: 5),
                                child: Row(
                                  children: [
                                    Expanded(flex: 5,
                                        child: Text(FormatTanggal.formatTanggal(
                                            value.listHistorySaldo[index]
                                                .tanggal))),
                                    Expanded(flex: 5,
                                        child: Text(value
                                            .listHistorySaldo[index].sumber)),
                                    Expanded(flex: 5,
                                        child: Text(value
                                            .listHistorySaldo[index].detail)),
                                    Expanded(flex: 4,
                                        child: Container(margin: EdgeInsets.only(right: 60),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(value
                                              .listHistorySaldo[index].harga))
                      ]),
                                        )),
                                    Expanded(flex: 7,
                                        child: Container(margin: EdgeInsets.only(right: 60),
                                          child: Text(textAlign: TextAlign.right,Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ? Rupiah.format(value
                                              .listHistorySaldo[index]
                                              .sisaSaldo):"Rp.      xxxxxxxxx"),
                                        )),
                                  ],
                                ),
                              ),
                            ))))
              ],
            )),
      ),
    );
  }
}
