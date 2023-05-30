import 'package:flutter/material.dart';
import 'package:cahaya/models/user.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/user/edit_user.dart';
import 'package:provider/provider.dart';

import 'delete_user.dart';

class UserTile extends StatefulWidget {
  final User supir;
  final int index;
  const UserTile(this.supir, this.index);

  @override
  State<UserTile> createState() => _UserTileState();
}




class _UserTileState extends State<UserTile> {
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
            Expanded(flex: 11, child: Text(widget.supir.username)),
            const Expanded(flex: 11, child: Text("------------")), Expanded(
                      flex: 11,
                      child: Text(widget.supir.owner?"Owner":"Admin",
                        )),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EditUser(widget.supir),
                  Provider.of<ProviderData>(context, listen: false).isOwner
                      ?widget.supir.owner?SizedBox():UserDelete(widget.supir)
                          
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
