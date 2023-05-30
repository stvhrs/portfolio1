import 'package:flutter/material.dart'; 
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchNama extends StatefulWidget {
  const SearchNama({super.key});

  @override
  State<SearchNama> createState() => _SearchNamaState();
}

class _SearchNamaState extends State<SearchNama> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 36,
        margin: const EdgeInsets.only(left: 35),
        width: MediaQuery.of(context).size.width * 0.15,
        child: TextFormField(
                              style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
          onChanged: (val) {
            Provider.of<ProviderData>(context, listen: false).searchsupir = val;
            Provider.of<ProviderData>(context, listen: false).searchTransaksi("",true);
          },
          decoration: const InputDecoration(
            hintText: 'Driver',
          ),
        ));
  }
}
