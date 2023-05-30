import 'package:cahaya/helper/rupiah_format.dart';
import 'package:cahaya/models/transaksi.dart';

import 'package:flutter/material.dart';
import 'package:cahaya/transaksi/transaksi_delete.dart';
import 'package:cahaya/transaksi/transaksi_edit.dart';
import 'package:cahaya/transaksi/transaksi_view.dart';
import 'package:provider/provider.dart';

import '../helper/format_tanggal.dart';
import '../providerData/providerData.dart';

class TransaksiTile extends StatefulWidget {
  final Transaksi _transaksi;
  final int index;

  const TransaksiTile(this._transaksi, this.index);

  @override
  State<TransaksiTile> createState() => _TransaksiTileState();
}

class _TransaksiTileState extends State<TransaksiTile> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index.isEven ? Colors.grey.shade200 : Colors.white,
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                widget.index.toString(),
              )),
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
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(
                  //   child: TransaksiView(
                  //     widget._transaksi,
                  //   ),
                  // ),
                  // Expanded(child: TransaksiView(widget._transaksi)),
                  Provider.of<ProviderData>(context, listen: false).isOwner
                      ? Expanded(child: TransaksiEdit(widget._transaksi))
                      : DateTime.parse(widget._transaksi.tanggalBerangkat)
                                      .month !=
                                  DateTime.now().month ||
                              DateTime.parse(widget._transaksi.tanggalBerangkat)
                                      .year !=
                                  DateTime.now().year
                          ? const Expanded(
                              child: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.dangerous,
                                color: Colors.transparent,
                              ),
                            ))
                          : Expanded(child: TransaksiEdit(widget._transaksi)),
                  Provider.of<ProviderData>(context, listen: false).isOwner
                      ? Expanded(child: TransaksiDelete(widget._transaksi))
                      : const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
