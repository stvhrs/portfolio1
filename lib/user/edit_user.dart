import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cahaya/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../providerData/providerData.dart';
import '../services/service.dart';

class EditUser extends StatefulWidget {
  final User supir;
  const EditUser(this.supir);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
bool hidden=true;
  @override final children = <int, Widget>{
    0: const Text('Admin', style: TextStyle(fontFamily: 'Nunito',fontSize: 14,fontWeight: FontWeight.bold,)),
    1: const Text('Owner', style: TextStyle(fontFamily: 'Nunito',fontSize: 14,fontWeight: FontWeight.bold,)),
  }; int currentSegment = 0;
 
@override
  void initState() {
   currentSegment=  widget.supir.owner ?1:0;
    super.initState();
  }
  
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
                title:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Edit User'), Padding(
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
                  child: StatefulBuilder(
                    builder: (context,setState,) {
                      return SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(readOnly: true,
                                  style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                initialValue: widget.supir.username,
                                decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: SizedBox(
                             
                              child: Icon(Icons.email),
                            ),
                                  hintText: 'Username',
                                ),
                                onChanged: (val) {
                                  widget.supir.username = val.toString();
                                },
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(obscureText: hidden,
                                  style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
                                initialValue: widget.supir.password,
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
                                  child: Icon(Icons.lock),
                                ),
                                  hintText: 'Password',
                                ),
                                onChanged: (val) {
                                  widget.supir.password = val.toString();
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
                                    child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      if (widget.supir.username.isEmpty ||
                          widget.supir.password.isEmpty) {
                        _btnController.error();
                        await Future.delayed(const Duration(seconds: 1));
                        _btnController.reset();
                        return;
                      }

                         var data = await Service.updatUser(
                            {'id_user':widget.supir.id,'username': widget.supir.username, "password": widget.supir.password,"status":currentSegment==0? "admin":"owner"});

                        if (data != null) {
                          Provider.of<ProviderData>(context, listen: false)
                              .updateUser(data);
                        }else{
                           _btnController.error();
                         await Future.delayed(const Duration(milliseconds: 500));
                          _btnController.reset();
                          return;
                        }

                        
                        _btnController.success();
                    
                      await Future.delayed(const Duration(seconds: 1), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('Edit',
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ))]);
            });
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.green,
      ),
    );
  }
}
