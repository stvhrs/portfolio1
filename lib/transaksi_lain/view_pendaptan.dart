// import 'dart:async';

// import 'package:cahaya/helper/rupiah_format.dart';
// import 'package:cahaya/models/mutasi_saldo.dart';
// import 'package:cahaya/models/perbaikan.dart';

// import 'package:cahaya/providerData/providerData.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:cahaya/services/service.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:provider/provider.dart';
// import 'package:web_date_picker/web_date_picker.dart';

// import '../helper/dropdown.dart';
// import '../helper/input_currency.dart';

// class ViewPendapatan extends StatefulWidget {
//   final MutasiSaldo perbaikan;
//   const ViewPendapatan(this.perbaikan);
//   @override
//   State<ViewPendapatan> createState() => _EditPendaptanState();
// }

// class _EditPendaptanState extends State<ViewPendapatan> {
//   List<String> listMobil = [];

 

//   final RoundedLoadingButtonController _btnController =
//       RoundedLoadingButtonController();
//   final TextEditingController mobilCont = TextEditingController();
  
//   TextStyle small = const TextStyle(fontSize: 13.5);
//  Widget _buildSize(widget, String ket, int flex) {
//     return Container(
//           margin: const EdgeInsets.only(bottom: 7, top: 7),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   '$ket :',
//                   style: const TextStyle(fontSize: 13.5),
//                 ),
//               ),
//               Expanded(flex: 2, child:SizedBox(height: 36,child: widget)),
//             ],
//           ));
    
//   }
//     Widget _buildSize2(widget, String ket, int flex) {
//     return Container(
//           margin: const EdgeInsets.only(bottom: 7, top: 7),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   '$ket :',
//                   style: const TextStyle(fontSize: 13.5),
//                 ),
//               ),
//               Expanded(flex: 2, child: widget),
//             ],
//           ));
    
//   }

//   @override
//   Widget build(BuildContext context) {
      
//     return IconButton(
//         icon: const Icon(
//           Icons.remove_red_eye,
//           color: Colors.grey,
//         ),
       
        
//         onPressed: () {
         

//           showDialog(
//               barrierDismissible: false,
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                     backgroundColor: Theme.of(context).primaryColor,
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const SizedBox(),
//                          Text(
//                           widget.perbaikan.pendapatan?"View Pemasukan":"'View Pengeluaran",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.white),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CircleAvatar(
//                               radius: 12,
//                               backgroundColor: Colors.white,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: const Icon(
//                                   Icons.close,
//                                   size: 13,
//                                   color: Colors.red,
//                                 ),
//                               )),
//                         ),
//                       ],
//                     ),
//                     titlePadding: const EdgeInsets.all(0),
//                     shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                     content: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: StatefulBuilder(
//                         builder: (BuildContext context, StateSetter setState) =>
//                             IntrinsicHeight(
//                           child: Container(
//                             padding: const EdgeInsets.only(
//                                 bottom: 20, left: 20, right: 20, top: 15),
//                             width: MediaQuery.of(context).size.width * 0.4,
//                             child:  SingleChildScrollView(
//                               child: Column(
//                                 children: [
                                 
//                                       _buildSize(
//                                                 Picker(lastDate: DateTime.now(),
//                                             height: 60,
//                                             initialDate: DateTime.parse(
//                                                 widget.perbaikan.tanggal),
//                                             dateformat: 'dd/MM/yyyy',
//                                             onChange: (value) {
//                                               if (value != null) {
//                                                 widget.perbaikan.tanggal =
//                                                     value.toIso8601String();
//                                               }
//                                             },
//                                           ),
//                                           'Tanggal',
//                                           1),
//                                       _buildSize(
//                                           TextFormField(readOnly: true,
//                                 style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
//                                             initialValue: widget.perbaikan.keterangan,
//                                             onChanged: (va) {
//                                               widget.perbaikan.keterangan = va;
//                                             },
//                                           ),
//                                           'Keterangan',
//                                           1),
                                     
//                                       _buildSize(
//                                           TextFormField(readOnly: true,
//                                 style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
//                                             initialValue:
//                                                 Rupiah.format(widget.perbaikan.harga),
//                                             onChanged: (va) {
//                                               widget.perbaikan.harga =
//                                                   Rupiah.parse(va);
//                                             },
//                                             inputFormatters: [
//                                               FilteringTextInputFormatter
//                                                   .digitsOnly,
//                                               CurrencyInputFormatter()
//                                             ],
//                                           ),
//                                           'Harga',
//                                           1),
                                  
                                
//                                       _buildSize(
//                                           TextFormField(readOnly: true,
//                                 style: const TextStyle(fontSize:13),textInputAction: TextInputAction.next,
//                                             initialValue: widget.perbaikan.nota,
//                                             onChanged: (va) {
//                                               widget.perbaikan.nota = va;
//                                             },
//                                           ),
//                                           'Nomor Nota',
//                                           2),
                                   
                                
//                                  ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ));
//               });
//         });
//   }
// }
