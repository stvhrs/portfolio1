import "dart:async";

import "package:cahaya/helper/rupiah_format.dart";
import "package:cahaya/models/mobil.dart";
import "package:cahaya/models/transaksi.dart";

import "package:cahaya/providerData/providerData.dart";
import 'package:cahaya/transaksi/datepicer.dart';
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:rounded_loading_button/rounded_loading_button.dart";
import "package:provider/provider.dart";


import '../helper/dropdown.dart';
import "../helper/format_tanggal.dart";
import "../helper/input_currency.dart";
import '../services/service.dart';

class TransaksiAdd extends StatefulWidget {
  @override
  State<TransaksiAdd> createState() => _TransaksiAddState();
}

class _TransaksiAddState extends State<TransaksiAdd> {
  List<String> listSupir = [];
  List<String> listMobil = [];
  final List<Transaksi> bulkTransaksi = [];
  FocusNode fd = FocusNode();

  TextEditingController controlerSisa = TextEditingController();
  TextEditingController controlerOngkos = TextEditingController();
  TextEditingController controlerKeluar = TextEditingController();
  TextEditingController controlerSupir = TextEditingController();
  TextEditingController controlerMobil = TextEditingController();
  TextEditingController controlerKeterangan = TextEditingController();
  TextEditingController controlerTujuan = TextEditingController();
  TextEditingController controlerKetMobil = TextEditingController();
  
  @override
  void initState() {
    Provider.of<ProviderData>(context, listen: false)
        .listSupir
        .where((element) => element.delted == false)
        .map((e) => e.nama_supir)
        .toList()
        .forEach((element) {
      if (listSupir.contains(element)) {
      } else {
        listSupir.add(element);
      }
    });
    List<Mobil> temp =
        Provider.of<ProviderData>(context, listen: false).listMobil;

    temp.removeWhere((element) => element.terjual);
    temp.map((e) => e.nama_mobil).toList().forEach((element) {
      if (listMobil.contains(element)) {
      } else {
        listMobil.add(element);
      }
    });
    listMobil.insert(0, "");
    listSupir.insert(0, "");
    controlerMobil.text = "";
    controlerSupir.text = "";
    super.initState();
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Transaksi transaksi;
  TextStyle small = const TextStyle(fontSize: 13.5);

  Widget _buildSize2(widget, String ket, int flex) {
    return
        //  Container(height: 50,
        //   // margin: EdgeInsets.only(
        //   //     right: ket == 'Jenis Mobil' || ket == "Ketik Tujuan" ? 0 : 50,
        //   //     bottom: ket == "ket_transaksi" ? 20 : 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //           margin: const EdgeInsets.only(
        //             right: 7,
        //           ),
        //           child: Text(
        //             "$ket :",
        //             style: const TextStyle(fontSize: 13.5),
        //           )),
        Container(
      margin: const EdgeInsets.only(bottom: 15, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // clipBehavior: Clip.none,
        // alignment: Alignment.centerLeft,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$ket :",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget,
          )
        ],
      ),
    );
  }

  Widget _buildSize(widget, String ket, int flex) {
    return
        //  Container(height: 50,
        //   // margin: EdgeInsets.only(
        //   //     right: ket == 'Jenis Mobil' || ket == "Ketik Tujuan" ? 0 : 50,
        //   //     bottom: ket == "ket_transaksi" ? 20 : 5),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Container(
        //           margin: const EdgeInsets.only(
        //             right: 7,
        //           ),
        //           child: Text(
        //             "$ket :",
        //             style: const TextStyle(fontSize: 13.5),
        //           )),
        Container(
      margin: const EdgeInsets.only(bottom: 15, left: 10),
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // clipBehavior: Clip.none,
        // alignment: Alignment.centerLeft,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$ket :",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Nunito"),
            ),
          ),
          Expanded(
            flex: 3,
            child: widget,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ElevatedButton.icon(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            "Input Ritase",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            transaksi = Transaksi.fromMap({
              "id_transaksi": "0",
              "id_mobil": "0",
              "plat_mobil": "",
              "id_supir": "0",
              "nama_supir": "",
              "tanggal": DateTime.now().toIso8601String(),
              "ket_transaksi": "",
              "tujuan": "0",
              "ongkosan": "0",
              "keluar": "0",
              "sisa": "0",
              "sender": Provider.of<ProviderData>(context, listen: false)
                  .user
                  .username
            });
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    contentPadding: const EdgeInsets.all(0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const Text(
                          "Input Transaksi",
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) =>
                            IntrinsicHeight(
                          child: Container(
                            height: 2000,
                            padding: const EdgeInsets.only(bottom: 20, top: 15),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(scrollbars: false),
                                          child: SingleChildScrollView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            child: Column(
                                              children: [
                                                _buildSize(
                                                    Picker(
                                                     fd: fd,
                                                      lastDate: DateTime.now(),
                                                      height: 36,
                                                      initialDate:
                                                          DateTime.now(),
                                                      dateformat: "dd/MM/yyyy",
                                                      onChange: (value) {
                                                        if (value != null) {
                                                          transaksi
                                                                  .tanggalBerangkat =
                                                              value
                                                                  .toIso8601String();
                                                        }
                                                      },
                                                    ),
                                                    "Tanggal",
                                                    1),
                                                _buildSize2(
                                                    DropDownField(
                                                      controller:
                                                          controlerSupir,
                                                      items: listSupir,
                                                      height: 28,
                                                      onValueChanged: (value) {
                                                        try {
                                                          setState(() {
                                                            transaksi.supir =
                                                                value;
                                                            controlerSupir
                                                                .text = value;
                                                            transaksi
                                                                .id_supir = Provider.of<
                                                                        ProviderData>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .listSupir
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .nama_supir ==
                                                                        value)
                                                                .id;
                                                          });
                                                        } catch (e) {
                                                          controlerSupir.text =
                                                              value;
                                                        }
                                                      },
                                                    ),
                                                    "Pilih Driver",
                                                    1),
                                                _buildSize2(
                                                    DropDownField(
                                                        controller:
                                                            controlerMobil,
                                                        items: listMobil,
                                                        height: 28,
                                                        onValueChanged:
                                                            (value) {
                                                          try {
                                                            setState(() {
                                                              // if (value ==
                                                              //     '') {
                                                              //   return;
                                                              // }
                                                              controlerMobil
                                                                  .text = value;
                                                              transaksi.mobil =
                                                                  value;
                                                              transaksi
                                                                  .id_mobil = Provider.of<
                                                                          ProviderData>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .backupListMobil
                                                                  .firstWhere(
                                                                      (element) =>
                                                                          element
                                                                              .nama_mobil ==
                                                                          value)
                                                                  .id;
                                                              controlerKetMobil
                                                                  .text = Provider.of<
                                                                          ProviderData>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .listMobil
                                                                  .firstWhere(
                                                                      (element) =>
                                                                          element
                                                                              .nama_mobil ==
                                                                          value)
                                                                  .keterangan_mobill;
                                                            });
                                                          } catch (e) {
                                                            controlerMobil
                                                                .text = value;
                                                          }
                                                        }),
                                                    'Pilih No Pol',
                                                    1),
                                                _buildSize(
                                                    TextFormField(
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      readOnly: true,
                                                      controller:
                                                          controlerKetMobil,
                                                      onChanged: (val) {},
                                                    ),
                                                    'Jenis Mobil',
                                                    1),
                                                _buildSize(
                                                    TextFormField(
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          controlerTujuan,
                                                      onChanged: (va) {
                                                        transaksi.tujuan = va;
                                                        setState(() {});
                                                      },
                                                    ),
                                                    "Ketik Tujuan",
                                                    1),
                                                _buildSize(
                                                    TextFormField(
                                                        style: const TextStyle(
                                                            fontSize: 13),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        controller:
                                                            controlerKeterangan,
                                                        onChanged: (val) {
                                                          transaksi.keterangan =
                                                              val;
                                                          setState(() {});
                                                        }),
                                                    "Keterangan",
                                                    2),
                                                _buildSize(
                                                    TextFormField(
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller:
                                                          controlerOngkos,
                                                      onChanged: (va) {
                                                        if (va.isNotEmpty &&
                                                            va.startsWith(
                                                                "Rp")) {
                                                          transaksi.ongkos =
                                                              Rupiah.parse(va);
                                                          if (transaksi.keluar >
                                                              Rupiah.parse(
                                                                  va)) {
                                                            controlerSisa.text =
                                                                "Tidak boleh minus";
                                                            setState(() {});
                                                          } else {
                                                            controlerSisa
                                                                .text = Rupiah.format(
                                                                    (transaksi
                                                                            .ongkos -
                                                                        transaksi
                                                                            .keluar))
                                                                .toString();
                                                            transaksi.sisa =
                                                                transaksi
                                                                        .ongkos -
                                                                    transaksi
                                                                        .keluar;
                                                            setState(() {});
                                                          }
                                                        } else {
                                                          transaksi.ongkos = 0;
                                                        }
                                                        setState(
                                                          () {},
                                                        );
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        CurrencyInputFormatter()
                                                      ],
                                                    ),
                                                    "Tarif",
                                                    1),
                                                _buildSize(
                                                    TextFormField(
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      controller:
                                                          controlerKeluar,
                                                      onChanged: (va) {
                                                        if (va.isNotEmpty &&
                                                            va.startsWith(
                                                                "Rp")) {
                                                          transaksi.keluar =
                                                              Rupiah.parse(va);

                                                          if (transaksi.ongkos <
                                                              Rupiah.parse(
                                                                  va)) {
                                                            controlerSisa.text =
                                                                "Tidak boleh minus";
                                                            setState(() {});
                                                          } else {
                                                            transaksi.sisa =
                                                                transaksi
                                                                        .ongkos -
                                                                    transaksi
                                                                        .keluar;
                                                            controlerSisa
                                                                .text = Rupiah.format(
                                                                    (transaksi
                                                                            .ongkos -
                                                                        transaksi
                                                                            .keluar))
                                                                .toString();
                                                            setState(() {});
                                                          }
                                                        } else {
                                                          transaksi.keluar = 0;
                                                        }
                                                        setState(
                                                          () {},
                                                        );
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        CurrencyInputFormatter()
                                                      ],
                                                    ),
                                                    "Biaya Keluar",
                                                    1),
                                                _buildSize(
                                                    TextFormField(
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      controller: controlerSisa,
                                                      readOnly: true,
                                                      onChanged: (va) {
                                                        if (va.isNotEmpty &&
                                                            va.startsWith(
                                                                "Rp")) {
                                                          transaksi.keluar =
                                                              Rupiah.parse(va);
                                                        } else {
                                                          transaksi.keluar = 0;
                                                        }
                                                        setState(
                                                          () {},
                                                        );
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        CurrencyInputFormatter()
                                                      ],
                                                    ),
                                                    "Sisa",
                                                    1),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.red)),
                                                onPressed: () {
                                                  controlerKetMobil.text = "";

                                                  controlerKeterangan.text = "";
                                                  controlerOngkos.text = "";
                                                  controlerKeluar.text = "";
                                                  controlerSisa.text = "";

                                                  controlerKetMobil.text = "";
                                                  controlerTujuan.text = "";
                                                  transaksi.keterangan = "";
                                                  transaksi.mobil = "";
                                                  transaksi.supir = "";
                                                  transaksi.keluar = 0;
                                                  transaksi.sisa = 0;
                                                  transaksi.ongkos = 0;
                                                  transaksi.tujuan = "";
                                                  transaksi.tanggalBerangkat =
                                                      DateTime.now()
                                                          .toIso8601String();

                                                  Transaksi.fromMap({
                                                    "id_transaksi": "0",
                                                    "id_mobil": "0",
                                                    "plat_mobil": "",
                                                    "id_supir": "0",
                                                    "nama_supir": "",
                                                    "tanggal": DateTime.now()
                                                        .toIso8601String(),
                                                    "ket_transaksi": "",
                                                    "tujuan": "0",
                                                    "ongkosan": "0",
                                                    "keluar": "0",
                                                    "sisa": "0",
                                                    "sender": Provider.of<
                                                                ProviderData>(
                                                            context,
                                                            listen: false)
                                                        .user
                                                        .username
                                                  });
                                                  fd.requestFocus();
                                                  controlerMobil.text = "";
                                                  controlerSupir.text = "";
                                                  setState(
                                                    () {},
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                                label: const Text(
                                                  "Hapus",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                )),
                                            Container(
                                              child: ElevatedButton.icon(
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_right_alt_rounded,
                                                    color: Colors.white,
                                                  ),
                                                  label: const Text(
                                                    "Masukan",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStatePropertyAll((transaksi
                                                                      .sisa <=
                                                                  0 ||
                                                              transaksi.supir ==
                                                                  "" ||
                                                              transaksi.mobil ==
                                                                  "" ||
                                                              transaksi.tujuan
                                                                  .isEmpty ||
                                                              transaksi.ongkos ==
                                                                  0 ||
                                                              controlerSisa.text ==
                                                                  "Tidak boleh minus")
                                                          ? Colors.grey
                                                          : Colors.green),
                                                      padding: MaterialStateProperty.all(
                                                          const EdgeInsets.only(
                                                              right: 10,
                                                              left: 15))),
                                                  onPressed: (transaksi.sisa <= 0 ||
                                                          transaksi
                                                              .supir.isEmpty ||
                                                          transaksi
                                                              .mobil.isEmpty ||
                                                          transaksi.tujuan.isEmpty ||
                                                          transaksi.ongkos == 0 ||
                                                          controlerSisa.text == "Tidak boleh minus")
                                                      ? null
                                                      : () {
                                                          Transaksi temp = Transaksi(
                                                              "",
                                                              transaksi
                                                                  .id_supir,
                                                              transaksi
                                                                  .id_mobil,
                                                              transaksi
                                                                  .tanggalBerangkat,
                                                              transaksi
                                                                  .keterangan,
                                                              transaksi.supir,
                                                              transaksi.mobil,
                                                              transaksi
                                                                  .keterangan_mobill,
                                                              transaksi.tujuan,
                                                              transaksi.keluar,
                                                              transaksi.ongkos,
                                                              transaksi.sisa,
                                                              Provider.of<ProviderData>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .user
                                                                  .username);

                                                          bulkTransaksi
                                                              .add(temp);
                                                          Transaksi.fromMap({
                                                            "id_transaksi": "0",
                                                            "id_mobil":
                                                                transaksi
                                                                    .id_mobil,
                                                            "plat_mobil": "",
                                                            "id_supir":
                                                                transaksi
                                                                    .id_supir,
                                                            "nama_supir": "",
                                                            "tanggal": transaksi
                                                                .tanggalBerangkat,
                                                            "ket_transaksi": "",
                                                            "tujuan": "0",
                                                            "ongkosan": "0",
                                                            "keluar": "0",
                                                            "sisa": "0",
                                                            "sender": Provider.of<
                                                                        ProviderData>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .user
                                                                .username
                                                          });
                                                          fd.requestFocus();

                                                          controlerKetMobil
                                                              .text = "";
                                                          controlerMobil.text =
                                                              "";
                                                          controlerSupir.text =
                                                              "";
                                                          controlerKeterangan
                                                              .text = "";
                                                          controlerOngkos.text =
                                                              "";
                                                          controlerKeluar.text =
                                                              "";
                                                          controlerSisa.text =
                                                              "";

                                                          controlerKetMobil
                                                              .text = "";
                                                          controlerTujuan.text =
                                                              "";
                                                          transaksi.keterangan =
                                                              "";
                                                          transaksi.mobil = "";
                                                          transaksi.supir = "";
                                                          transaksi.keluar = 0;
                                                          transaksi.sisa = 0;
                                                          transaksi.ongkos = 0;
                                                          transaksi.tujuan = "";

                                                          setState(
                                                            () {},
                                                          );
                                                        }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalDivider(),
                                Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Column(children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5))),
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 12.5,
                                            left: 15,
                                            right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "No",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Tanggal",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 6,
                                                child: Text(
                                                  "No Pol",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  'Driver',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 8,
                                                child: Text(
                                                  "Tujuan",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Tarif",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Keluar",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                                flex: 7,
                                                child: Text(
                                                  "Sisa",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                )),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Aksi",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView(
                                            addAutomaticKeepAlives: false,
                                            padding: EdgeInsets.zero,
                                            children: bulkTransaksi.reversed
                                                .toList()
                                                .mapIndexed(
                                                    (index, element) =>
                                                        Container(
                                                          color: index.isEven
                                                              ? Colors
                                                                  .grey.shade200
                                                              : const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  189,
                                                                  193,
                                                                  221),
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 5,
                                                                      bottom: 5,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Text(
                                                                          style:
                                                                              small,
                                                                          (index + 1)
                                                                              .toString(),
                                                                        )),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            maxLines:
                                                                                1,
                                                                            FormatTanggal.formatTanggal(element.tanggalBerangkat).toString())),
                                                                    Expanded(
                                                                        flex: 6,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            element.mobil)),
                                                                    Expanded(
                                                                        flex: 8,
                                                                        child:
                                                                            Text(
                                                                          style:
                                                                              small,
                                                                          element
                                                                              .supir,
                                                                        )),
                                                                    Expanded(
                                                                        flex: 8,
                                                                        child: Text(
                                                                            style:
                                                                                small,
                                                                            element.tujuan)),

                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(
                                                                                right:
                                                                                    10),
                                                                            child:
                                                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                              Text("Rp."),
                                                                              Text(Rupiah.format2(element.ongkos))
                                                                            ]))),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(
                                                                                right:
                                                                                    10),
                                                                            child:
                                                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                              Text("Rp."),
                                                                              Text(Rupiah.format2(element.keluar))
                                                                            ]))),
                                                                    Expanded(
                                                                        flex: 7,
                                                                        child: Container(
                                                                            margin: EdgeInsets.only(
                                                                                right:
                                                                                    10),
                                                                            child:
                                                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                              Text("Rp."),
                                                                              Text(Rupiah.format2(element.sisa))
                                                                            ]))),
                                                                    Expanded(
                                                                        flex: 3,
                                                                        child: Shortcuts
                                                                            .manager(
                                                                          manager:
                                                                              ShortcutManager(
                                                                            shortcuts: Map.of(WidgetsApp.defaultShortcuts)
                                                                              ..remove(LogicalKeySet(LogicalKeyboardKey.enter))
                                                                              ..remove(LogicalKeySet(LogicalKeyboardKey.numpadEnter)),
                                                                          ),
                                                                          child: GestureDetector(
                                                                              onTap: () {
                                                                                bulkTransaksi.remove(element);
                                                                                setState(() {});
                                                                              },
                                                                              child: const Icon(
                                                                                Icons.delete_forever,
                                                                                color: Colors.red,
                                                                              )),
                                                                        ))
                                                                    // Expanded(
                                                                    //     flex: 7,
                                                                    //     child: Text(element.listPerbaikan.isEmpty
                                                                    //         ? "-"
                                                                    //         : Rupiah.format(
                                                                    //             totalPerbaikan(element.listPerbaikan)))),
                                                                  ])),
                                                        ))
                                                .toList()),
                                      ),
                                      bulkTransaksi.isEmpty
                                          ? const SizedBox()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                RoundedLoadingButton(
                                                    width: 120,
                                                    color: Colors.red,
                                                    controller:
                                                        RoundedLoadingButtonController(),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Batal',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                                RoundedLoadingButton(
                                                  width: 120,
                                                  color: Colors.green,
                                                  elevation: 10,
                                                  successColor: Colors.green,
                                                  errorColor: Colors.red,
                                                  controller: _btnController,
                                                  onPressed: () async {
                                                    if (bulkTransaksi.isEmpty ||
                                                        bulkTransaksi.every(
                                                            (element) =>
                                                                element.sisa <
                                                                1)) {
                                                      _btnController.error();
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 1));
                                                      _btnController.reset();
                                                      return;
                                                    }

                                                    for (var element
                                                        in bulkTransaksi) {
                                                      var data = await Service
                                                          .postTransaksi({
                                                        "id_mobil":
                                                            element.id_mobil,
                                                        "plat_mobil":
                                                            element.mobil,
                                                        "id_supir":
                                                            element.id_supir,
                                                        "nama_supir":
                                                            element.supir,
                                                        "tanggal": element
                                                            .tanggalBerangkat,
                                                        "ket_transaksi":
                                                            element.keterangan,
                                                        "tujuan":
                                                            element.tujuan,
                                                        "ongkosan": element
                                                            .ongkos
                                                            .toString(),
                                                        "keluar": element.keluar
                                                            .toString(),
                                                        "sisa": element.sisa
                                                            .toString(),
                                                        "sender": Provider.of<
                                                                    ProviderData>(
                                                                context,
                                                                listen: false)
                                                            .user
                                                            .username
                                                      });

                                                      if (data != null) {
                                                        data.supir =
                                                            element.supir;
                                                        data.mobil =
                                                            element.mobil;
                                                        Provider.of<ProviderData>(
                                                                context,
                                                                listen: false)
                                                            .addTransaksi(data);
                                                      } else {
                                                        _btnController.error();
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {});
                                                        _btnController.reset();
                                                        return;
                                                      }
                                                    }

                                                    _btnController.success();

                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 1), () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: const Text("Simpan",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                    ]))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).then((value) => {
                  bulkTransaksi.clear(),
                  controlerKetMobil.text = "",
                  controlerMobil.text = "",
                  controlerKeterangan.text = "",
                  controlerOngkos.text = "",
                  controlerKeluar.text = "",
                  controlerSisa.text = "",
                  controlerSupir.text = "",
                  controlerKetMobil.text = "",
                  controlerTujuan.text = "",
                  Transaksi.fromMap({
                    "id_transaksi": "0",
                    "id_mobil": "0",
                    "plat_mobil": "",
                    "id_supir": "0",
                    "nama_supir": "",
                    "tanggal": DateTime.now().toIso8601String(),
                    "ket_transaksi": "",
                    "tujuan": "0",
                    "ongkosan": "0",
                    "keluar": "0",
                    "sisa": "0",
                    "sender": Provider.of<ProviderData>(context, listen: false)
                        .user
                        .username
                  })
                });
          }),
    );
  }
}
