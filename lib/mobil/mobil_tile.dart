import 'package:flutter/material.dart';
import 'package:cahaya/mobil/delete_mobil.dart';
import 'package:cahaya/mobil/edit_mobil.dart';
import 'package:cahaya/models/mobil.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';



class MobilTile extends StatefulWidget {
  final Mobil mobil;
  final int index;
  const MobilTile(this.mobil, this.index);

  @override
  State<MobilTile> createState() => _MobilTileState();
}

class _MobilTileState extends State<MobilTile> {
  bool deleteable = true;
  @override
  initState(){
      for (var element
        in Provider.of<ProviderData>(context, listen: false).listTransaksi) {
      if (element.id_mobil ==
          widget.mobil
              .id){deleteable = false;}
      
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
  
    //print(deleteable);
    return InkWell(
                            child: Container(
                              color:widget. index.isEven
                                  ? Colors.white
                                  : Colors.grey.shade200,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 11,
                                      child:
                                          Text(widget.mobil.nama_mobil)),
                                  Expanded(
                                      flex: 11,
                                      child: Text(widget.mobil.keterangan_mobill)),
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        EditMobil(widget.mobil),
                                        Provider.of<ProviderData>(context,
                                                    listen: false)
                                                .isOwner
                                            ? DeleteMobil(widget.mobil)
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
