import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cahaya/helper/uppercase.dart';
import 'package:cahaya/services/service.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';

class TambahUser extends StatefulWidget {

  const TambahUser({super.key});

  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
bool hidden=true;
    String namaMobil = '';
    String noHp = '';
    
  final children = <int, Widget>{
    0: const Text('Admin', style: TextStyle(fontFamily: 'Nunito',fontSize: 14,fontWeight: FontWeight.bold,)),
    1: const Text('Owner', style: TextStyle(fontFamily: 'Nunito',fontSize: 14,fontWeight: FontWeight.bold,)),
  }; int currentSegment = 0;
 

  
  @override
  Widget build(BuildContext context) {
TextEditingController satu=TextEditingController();
TextEditingController satu2=TextEditingController();
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green)),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tambah User'),
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
                    child:StatefulBuilder(
                    builder: (context,setState,) {
                        return SizedBox(
                          width: 500,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(controller: satu,
                                  style: const TextStyle(fontSize: 13.5),
                                  textInputAction: TextInputAction.next,inputFormatters: [],
                                  decoration:   const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: SizedBox(
                             
                              child: Icon(Icons.email),
                            ),
                                    hintText: 'Username',
                                  ),
                                  onChanged: (val) {
                                    namaMobil = val.toString();
                                  },
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TextFormField(controller:satu2 ,obscureText: hidden,
                                  style: const TextStyle(fontSize: 13.5),
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    hidden = !hidden;
                                    setState(() {});
                                  },
                                  icon: hidden
                                      ? const Icon(Icons.remove_red_eye_outlined)
                                      :  const Icon(Icons.remove_red_eye_rounded),
                                ),
                                prefixIcon: const SizedBox(
                                  child:Icon(Icons.lock),
                                ),
                                    hintText: 'Password',
                                  ),
                                  onChanged: (val) {
                                    noHp = val.toString();
                                  },
                                  maxLines: 1,
                                ),
                              ),Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CupertinoSlidingSegmentedControl<int>(
                    children: children,
                    onValueChanged:(int? newValue) {
    setState(() {
      currentSegment = newValue!;
    });
  },
                    groupValue: currentSegment,
                  ),
                ),
                            ],
                          ),
                        );
                      }
                    ),
                  ),
                  actions: <Widget>[
                   Container(margin: const EdgeInsets.only(top: 10),
                                    child:  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [RoundedLoadingButton(width: 120,color: Colors.red,controller:
                                         RoundedLoadingButtonController(), onPressed: (){
                                          Navigator.of(context).pop();
                                         }, child: const Text('Batal',
                                                style: TextStyle(color: Colors.white))),
                                          RoundedLoadingButton(width: 120,
                                            color: Theme.of(context).primaryColor,
                      elevation: 10,
                      successColor: Colors.green,
                      errorColor: Colors.red,
                      controller: _btnController,
                      onPressed: () async {
                        if (noHp.isEmpty || namaMobil.isEmpty) {
                          _btnController.error();
                          await Future.delayed(const Duration(seconds: 1));
                          _btnController.reset();
                          return;
                        }
                        var data = await Service.postUser(
                            {'username': namaMobil, "password": noHp,"status":currentSegment==0? "admin":"owner"});

                        if (data != null) {
                          Provider.of<ProviderData>(context, listen: false)
                              .addUser(data);
                        }else{
                          _btnController.error();
                         await Future.delayed(const Duration(milliseconds: 500));
                          _btnController.reset();
                          return;

                        }

                        _btnController.success();

                        await Future.delayed(const Duration(seconds: 1), () {
                          namaMobil="";
                          noHp="";
                          satu.clear();
                          satu2.clear();
                          
                       Navigator.of(context).pop();
                        });
                      },
                      child: const Text('Simpan',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                                    ))]);
              });
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Tambah',
          style: TextStyle(color: Colors.white),
        ));
  }
}
