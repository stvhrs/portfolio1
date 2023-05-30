import 'package:flutter/material.dart';
import 'package:cahaya/models/perbaikan.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';
import '../services/service.dart';

class AdministrasiDelete extends StatelessWidget {
  final Perbaikan perbaikan;
  AdministrasiDelete(this.perbaikan);
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Delete"),
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
                              color: Colors.red,
                            ),
                          )),
                    ),
                  ],
                ),
                content: IntrinsicHeight(
                  child: SizedBox(
                    width: 500,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: const Text('Apakah Anda Yakin ?'),
                    ),
                  ),
                ),
                actions: <Widget>[
                  RoundedLoadingButton(
                    color: Colors.red,
                    elevation: 10,
                    successColor: Colors.green,
                    errorColor: Colors.red,
                    controller: _btnController,
                    onPressed: () async {
                      var data = await Service.deletePerbaikan(perbaikan.id);

                      if (data != null) {
                        Provider.of<ProviderData>(context, listen: false)
                            .deletePerbaikan(data);
                      } else {
                        _btnController.error();  _btnController.error();
                                                     await Future.delayed(
                                            const Duration(seconds: 1), () {
                                           _btnController.reset();
                                        });
                                        return;
                      }

                      _btnController.success();

                      await Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              );
            });
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
