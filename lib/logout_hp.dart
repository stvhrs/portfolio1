import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providerData/providerData.dart';

class HpLogout extends StatelessWidget {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),
      
        child:
             
              IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actionsPadding:
                              const EdgeInsets.only(right: 15, bottom: 15),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Log Out"),
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
                                margin: const EdgeInsets.only(bottom: 5),
                                child: const Text('Apakah Anda Yakin ?'),
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            RoundedLoadingButton(
                              color: Colors.red,width: 100,
                              elevation: 10,
                              successColor: Colors.green,
                              errorColor: Colors.red,
                              controller: _btnController,
                              onPressed: () async {
                                await Future.delayed(const Duration(seconds: 1),
                                    () async {
                               
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                            await      prefs.clear();
                                  Provider.of<ProviderData>(context,
                                          listen: false)
                                      .logout();
                                         Navigator.of(context).pop();
                                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => MyHomePage(title: ''),));
                                });
                              },
                              child: const Text('Logout',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.red,
                ),
              ), 
          
        ),
    );
    
  }
}
