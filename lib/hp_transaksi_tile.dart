import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/transaksi.dart';

import 'package:flutter/material.dart';
import 'package:cahaya/transaksi/transaksi_delete.dart';
import 'package:cahaya/transaksi/transaksi_edit.dart';
import 'package:cahaya/transaksi/transaksi_view.dart';
import 'package:provider/provider.dart';

import '../helper/format_tanggal.dart';
import '../providerData/providerData.dart';

class HpTransaksiTile extends StatefulWidget {
  final Transaksi _transaksi;
  final int index;

  const HpTransaksiTile(this._transaksi, this.index);

  @override
  State<HpTransaksiTile> createState() => _HpTransaksiTileState();
}

class _HpTransaksiTileState extends State<HpTransaksiTile> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index.isEven ? Colors.grey.shade200 : Colors.white,
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         
          Expanded(
              flex: 5,
              child: Text(
                  maxLines: 1,
                  FormatTanggal.formatTanggal(
                          widget._transaksi.tanggalBerangkat)
                      .toString())),

          Expanded(flex: 5, child: Text(widget._transaksi.mobil)),

          Expanded(
              flex: 5,
              child: Text(
                widget._transaksi.supir,
              )),
          Expanded(flex: 5, child: Text(widget._transaksi.tujuan)),
          Expanded(flex: 5, child: Text(widget._transaksi.keterangan)),

          Expanded(
              flex: 5,
              child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rp."),
                      Text(Rupiah.format2(widget._transaksi.ongkos)),
                    ],
                  ))),
          Expanded(
              flex: 5,
              child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget._transaksi.keluar))
                      ]))),
          Expanded(
              flex: 5,
              child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rp."),
                        Text(Rupiah.format2(widget._transaksi.sisa))
                      ]))),
          // Expanded(
          //     flex: 7,
          //     child:Container(margin: EdgeInsets.only(right: 30),child: Text(widget._transaksi.listPerbaikan.isEmpty
          //         ? '-'
          //         : Rupiah.format(
          //             totalPerbaikan(widget._transaksi.listPerbaikan)))),
          
        ],
      ),
    );
  }
}
