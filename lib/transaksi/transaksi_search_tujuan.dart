import 'package:flutter/material.dart'; 
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchTujuan extends StatefulWidget {
  const SearchTujuan({super.key});

  @override
  State<SearchTujuan> createState() => _SearchTujuanState();
}

class _SearchTujuanState extends State<SearchTujuan> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 36,
        margin: const EdgeInsets.only(left: 35),
        width: MediaQuery.of(context).size.width * 0.15,
        child: TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
          onChanged: (val) {
            Provider.of<ProviderData>(context, listen: false).searchtujuan =
                val;
            Provider.of<ProviderData>(context, listen: false).searchTransaksi("",true);
          },
          decoration: const InputDecoration(
            hintText: 'Tujuan',
          ),
        ));
  }
}
