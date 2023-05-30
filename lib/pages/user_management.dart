import 'package:flutter/material.dart';
import 'package:cahaya/models/user.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:cahaya/services/service.dart';
import 'package:cahaya/user/tambah_user.dart';
import 'package:cahaya/user/user_tile.dart';
import 'package:provider/provider.dart';
import 'package:cahaya/helper/custompaint.dart';
class UserManagement extends StatefulWidget {
  const UserManagement({super.key});

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
    late List<User> listUser;

 
  bool loading = true;
  initData() async {
//    test=      await Service.test2();
// await Service.test();
// await Service.postSupir();
// await Service.deleteSupir();
// await Service.test3();
    listUser = await Service.getUser();
if (!mounted) return;
  Provider.of<ProviderData>(context,listen: false).listUser=listUser;
  loading = false;

    setState(() {});
    
  }
  @override
  void initState() {
    if (mounted){   initData();}
   
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return  loading==true
        ? Center(
            child: CustomPaints(),
          )
        : Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 25),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                width: 10,
                strokeAlign: StrokeAlign.center),
            color: const Color.fromRGBO(244, 244, 252, 1),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              padding: const EdgeInsets.only(
                  right: 30, left: 30, bottom: 10, top: 5),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              child: const Text(
                'Daftar User',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
               
                Expanded(flex: 4, child: SizedBox()),
                TambahUser()
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              color: Theme.of(context).colorScheme.primary,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 11,
                      child: Text(
                        'Username',
                        style: Theme.of(context).textTheme.displayMedium,
                      )),
                  Expanded(
                      flex: 11,
                      child: Text('Password',
                          style: Theme.of(context).textTheme.displayMedium)), Expanded(
                      flex: 11,
                      child: Text('Role',
                          style: Theme.of(context).textTheme.displayMedium)),
                  Expanded(
                      flex: 3,
                      child: Text(' Aksi',
                          style: Theme.of(context).textTheme.displayMedium))
                ],
              ),
            ),
            Consumer<ProviderData>(builder: (context, c, h) {
             List<User> data=c.listUser.reversed.toList() ;
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                     
                      
                      return UserTile(data[index],index);},
                  ));
            })
          ],
        ));
  }
}
