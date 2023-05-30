import 'dart:convert';
import 'dart:developer';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:cahaya/models/jual_beli_mobil.dart';
import 'package:cahaya/models/perbaikan.dart';
import 'package:cahaya/pages/administrasi_page.dart';

import 'package:cahaya/pages/daftar_supir.dart';
import 'package:cahaya/pages/dashboard..dart';
import 'package:cahaya/pages/jual_beli.dart';
import 'package:cahaya/pages/kas_tahun.dart';
import 'package:cahaya/pages/laporan_bulanan.dart';
import 'package:cahaya/pages/laporan_kas.dart';
import 'package:cahaya/pages/mutasi_saldo.dart';
import 'package:cahaya/pages/pengeluran.dart';
import 'package:cahaya/pages/pendapatan.dart';

import 'package:cahaya/pages/perbaikan_page.dart';
import 'package:cahaya/pages/rekap_unit.dart';

import 'package:cahaya/pages/transaksi_page.dart';
import 'package:cahaya/pages/user_management.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/services/service.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/mutasi_saldo.dart';
import 'models/user.dart';
import 'pages/daftar_mobil.dart';
import 'models/mobil.dart';
import 'models/supir.dart';
import 'models/transaksi.dart';
import 'package:cahaya/helper/custompaint.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  late List<Transaksi> listTransaksi;
  late List<Supir> listSupir;
  late List<Mobil> listMobil;
  late List<Perbaikan> listPerbaikan;
  late List<JualBeliMobil> listJualBeliMobil;
  late List<MutasiSaldo> listMutasiSaldo;
  late String username="Demo";
  String test = '';
  bool loading = true;
  initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var data = prefs.getString('data');
      if (data != null) {
        //print(jsonDecode(data));
        User? user = await Service.getUserId(jsonDecode(data)["id_user"]);
        if (user == null ||
            user.password != jsonDecode(data)["password"] ||
            user.username != jsonDecode(data)["username"]) {
          await prefs.clear();
          Provider.of<ProviderData>(context, listen: false).logout();
          loading = false;
          setState(() {});
          return;
        }
        Provider.of<ProviderData>(context, listen: false).user = user;

        // ignore: use_build_context_synchronously
        Provider.of<ProviderData>(context, listen: false).login();
        if (user.owner) {
          //print('owner');
          Provider.of<ProviderData>(context, listen: false).owner();
        } else {
          //print('admin');
          Provider.of<ProviderData>(context, listen: false).admin();
        }
        username = jsonDecode(data)['username'];

        loading = false;
      }

      listTransaksi = await Service.getAllTransaksi();
      listSupir = await Service.getAllSupir();
      listPerbaikan = await Service.getAllPerbaikan();

      listJualBeliMobil = await Service.getAlljualBeli();
      listMobil = await Service.getAllMobil(listPerbaikan);
      listMutasiSaldo = await Service.getAllMutasiSaldo();

      Provider.of<ProviderData>(context, listen: false).setData([],
          listTransaksi,
          false,
          listMobil,
          listSupir,
          listPerbaikan,
          listJualBeliMobil,
          listMutasiSaldo);
      sideMenu.addListener((p0) {
        page.jumpToPage(p0);
      });
      loading = false;
      setState(() {});
    } catch (e) {
      loading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    if (mounted) {
      initData();
    }
    super.initState();
  }

  int _selectedIndex = 0;
  List<Widget> get wid => [
        DashBoardPage(username),
        const DaftarMobil(),
        const DaftarSupir(),
        const JualBeli(),
        const TransaksiPage(),
        const PerbaikanPage(),
        const AdministrasiPage(),
        const CashFlow(),
        const CashFlow1(),
        const LaporanBulanan(),
        const KasTahun(),
        const RekapUnit(),
        const LaporanKas(),
        const MutasiSaldoPage(),
        const UserManagement()
      ];
  final List<bool> _open = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    //log(build");

    var item = const TextStyle(
        fontFamily: 'Nunito',
        fontSize: 11.5,
        fontWeight: FontWeight.bold,
        color: Colors.white);
    return loading
        ? Center(
            child: CustomPaints(),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.90),
                    width: MediaQuery.of(context).size.width * 0.13,
                    height: MediaQuery.of(context).size.height,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: false,
                      ),
                      child: ListTileTheme(
                        dense: true,
                        child: SingleChildScrollView(
                          controller: null,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('images/title.png'),
                                    )),
                              ),
                              Container(
                                  color: _selectedIndex == 0
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).primaryColor,
                                  child: ListTile(
                                    visualDensity:
                                        VisualDensity(vertical: -4.0),
                                    iconColor: Colors.white,
                                    minLeadingWidth: 10,
                                    textColor: _selectedIndex == 0
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Colors.white,
                                    onTap: () {
                                      _selectedIndex = 0;
                                      setState(() {});
                                    },
                                    leading: const Icon(
                                        Icons.space_dashboard_rounded),
                                    title: Text(style: item, 'Dashboard'),
                                  )),
                              ExpansionTile(
                                childrenPadding: null,
                                collapsedIconColor: Colors.white,
                                iconColor: Colors.white,
                                title: Text(
                                  style: item,
                                  'Daftar Unit',
                                ),
                                children: <Widget>[
                                  Container(
                                      color: _selectedIndex == 1
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 1;
                                          setState(() {});
                                        },
                                        leading: const Icon(Icons.fire_truck),
                                        title:
                                            Text(style: item, 'Daftar Mobil'),
                                      )),
                                  Container(
                                      color: _selectedIndex == 2
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 2
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 2;
                                          setState(() {});
                                        },
                                        leading: const Icon(Icons.people),
                                        title:
                                            Text(style: item, 'Daftar Driver'),
                                      )),
                                Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ?   Container(
                                      color: _selectedIndex == 3
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 3
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 3;
                                          setState(() {});
                                        },
                                        leading: const Icon(Icons.inventory),
                                        title:
                                            Text(style: item, 'Jual Beli Unit'),
                                      )):SizedBox()
                                ],
                              ),
                              ExpansionTile(
                                childrenPadding: null,
                                collapsedIconColor: Colors.white,
                                iconColor: Colors.white,
                                title: Text(
                                  style: item,
                                  'Transaksi',
                                ),
                                children: <Widget>[
                                  Container(
                                      color: _selectedIndex == 4
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 4
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 4;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.currency_exchange_rounded),
                                        title: Text(style: item, 'Ritase'),
                                      )),
                                  Container(
                                      color: _selectedIndex == 5
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 5
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 5;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.engineering_rounded),
                                        title: Text(style: item, 'Perbaikan'),
                                      )),
                                  Container(
                                      color: _selectedIndex == 6
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 6
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 6;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.document_scanner_sharp),
                                        title:
                                            Text(style: item, 'Administrasi'),
                                      )),
                                ],
                              ),
                              ExpansionTile(
                                  childrenPadding: null,
                                  collapsedIconColor: Colors.white,
                                  iconColor: Colors.white,
                                  title: Text(
                                    style: item,
                                    'Transaksi lain-lain',
                                  ),
                                  children: <Widget>[
                                    Container(
                                        color: _selectedIndex == 7
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        child: ListTile(
                                          visualDensity:
                                              VisualDensity(vertical: -4.0),
                                          iconColor: Colors.white,
                                          minLeadingWidth: 10,
                                          textColor: _selectedIndex == 7
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Colors.white,
                                          onTap: () {
                                            _selectedIndex = 7;
                                            setState(() {});
                                          },
                                          leading:
                                              const Icon(Icons.compare_arrows),
                                          title:
                                              Text(style: item, 'Pengeluaran'),
                                        )),
                                    Container(
                                        color: _selectedIndex == 8
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        child: ListTile(
                                          visualDensity:
                                              VisualDensity(vertical: -4.0),
                                          iconColor: Colors.white,
                                          minLeadingWidth: 10,
                                          textColor: _selectedIndex == 8
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Colors.white,
                                          onTap: () {
                                            _selectedIndex = 8;
                                            setState(() {});
                                          },
                                          leading:
                                              const Icon(Icons.compare_arrows),
                                          title: Text(style: item, 'Pemasukan'),
                                        ))
                                  ]),
                              ExpansionTile(
                                childrenPadding: null,
                                collapsedIconColor: Colors.white,
                                iconColor: Colors.white,
                                title: Text(
                                  style: item,
                                  'Laporan Unit',
                                ),
                                children: <Widget>[
                                  Container(
                                      color: _selectedIndex == 9
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 8
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 9;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.monitor_heart_rounded),
                                        title:
                                            Text(style: item, 'Rekap Bulanan'),
                                      )),
                                  Container(
                                      color: _selectedIndex == 10
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 10
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 10;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.calendar_month_rounded),
                                        title:
                                            Text(style: item, 'Rekap Tahunan'),
                                      )),
                                  Container(
                                      color: _selectedIndex == 11
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 11
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 11;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.auto_graph_rounded),
                                        title:
                                            Text(style: item, 'Armada Tahunan'),
                                      )),
                                ],
                              ),
                              ExpansionTile(
                                childrenPadding: null,
                                collapsedIconColor: Colors.white,
                                iconColor: Colors.white,
                                title: Text(
                                  style: item,
                                  'Kas',
                                ),
                                children: <Widget>[
                              Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ?     Container(
                                      color: _selectedIndex == 12
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context).primaryColor,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 12
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 12;
                                          setState(() {});
                                        },
                                        leading:
                                            const Icon(Icons.shopify_rounded),
                                        title: Text(style: item, 'Laporan Kas'),
                                      )):SizedBox(),
                                  Container(
                                      color: _selectedIndex == 13
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context).primaryColor,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 13
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 13;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.attach_money_rounded),
                                        title: Text(style: item, 'Mutasi'),
                                      ))
                                ],
                              ),
                              Provider.of<ProviderData>(context, listen: false)
                                      .isOwner
                                  ? Container(
                                      color: _selectedIndex == 14
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context).primaryColor,
                                      child: ListTile(
                                        visualDensity:
                                            VisualDensity(vertical: -4.0),
                                        iconColor: Colors.white,
                                        minLeadingWidth: 10,
                                        textColor: _selectedIndex == 14
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white,
                                        onTap: () {
                                          _selectedIndex = 14;
                                          setState(() {});
                                        },
                                        leading: const Icon(
                                            Icons.emoji_people_rounded),
                                        title: Text(
                                            style: item, 'User Management'),
                                      ))
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    )),
                Expanded(child: wid[_selectedIndex]),
              ],
            ));
  }
}
