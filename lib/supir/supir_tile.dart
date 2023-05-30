import 'package:flutter/material.dart';
import 'package:cahaya/models/supir.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/supir/edit_supir.dart';
import 'package:provider/provider.dart';

import 'delete_supir.dart';

class SupirTile extends StatefulWidget {
  final Supir supir;
  final int index;
  const SupirTile(this.supir, this.index);

  @override
  State<SupirTile> createState() => _SupirTileState();
}




class _SupirTileState extends State<SupirTile> {
  bool deleteable = true;
  @override
  void initState() {
   for (var element
        in Provider.of<ProviderData>(context, listen: false).listTransaksi) {
      if (element.id_supir == widget.supir.id) {
        deleteable = false;
      }
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    //print(deleteable);
    return InkWell(
      child: Container(
        color: widget.index.isEven ? Colors.white : Colors.grey.shade200,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Expanded(flex: 11, child: Text(widget.supir.nama_supir)),
            Expanded(flex: 11, child: Text(widget.supir.nohp_supir)),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EditSupir(widget.supir),
                  Provider.of<ProviderData>(context, listen: false).isOwner
                      ?SupirDelete(widget.supir)
                          
                      : const SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
