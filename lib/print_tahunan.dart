/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:cahaya/models/kas_tahun.dart';
import 'package:cahaya/models/keuangan_bulanan.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'helper/rupiah_format.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const sep = 120.0;

Future<Uint8List> generateResume2(
    PdfPageFormat format, List<KasModel> as) async {
         DateTime dateTime = DateTime.parse(DateTime.now().toIso8601String());
String yourDateTime = DateFormat('HH:mm dd-MM-yyyy').format(dateTime);
  final document = pw.Document();
  pw.TextStyle bold = pw.TextStyle(fontWeight: pw.FontWeight.bold);
  pw.TextStyle small = const pw.TextStyle(fontSize: 10);
pw.ImageProvider asu = pw.MemoryImage(
    (await rootBundle.load('images/bg.png')).buffer.asUint8List(),
  );
  buildChildren(List<KeuanganBulanan> bulanans) {
    return bulanans.mapIndexed(
      (index, element) => pw.Container(
        padding: const pw.EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: 15,
        ),
        child: pw.Row(
          children: [
            pw.Expanded(flex: 4, child: pw.Text(element.bulan, style: small)),
            pw.Expanded(
                flex: 7,
                child:  pw.Expanded(
                      flex: 7,
                      child: pw. Container(
                  margin:pw. EdgeInsets.only(right: 20),
                  child:pw. Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Rp.",style: small),
                    pw.Text(
                        style: small,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format2(element.totalOngkos),
                      )
                    ],
                  )) ),),
            pw.Expanded(
                flex: 7,
                child:  pw.Expanded(
                      flex: 7,
                      child: pw. Container(
                  margin:pw. EdgeInsets.only(right: 20),
                  child:pw. Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Rp.",style: small),
                    pw.Text(
                        style: small,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format2(element.totalKeluar),
                      )
                    ],
                  )) ),),
            pw.Expanded(
                flex: 7,
                child: pw.Expanded(
                      flex: 7,
                      child: pw. Container(
                  margin:pw. EdgeInsets.only(right: 20),
                  child:pw. Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Rp.",style: small),
                    pw.Text(
                        style: small,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format2(element.totalSisa),
                      )
                    ],
                  )) ),),
            pw.Expanded(
                flex: 7,
                child:  pw.Expanded(
                      flex: 7,
                      child: pw. Container(
                  margin:pw. EdgeInsets.only(right: 20),
                  child:pw. Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Rp.",style: small),
                    pw.Text(
                        style: small,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format2(element.totalPerbaikan),
                      )
                    ],
                  )) ),),
            pw.Expanded(
                flex: 7,
                child: pw.Expanded(
                      flex: 7,
                      child: pw. Container(
                  margin:pw. EdgeInsets.only(right: 20),
                  child:pw. Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Rp.",style: small),
                    pw.Text(
                        style: small,
                        textAlign: pw.TextAlign.left,
                        Rupiah.format2(element.totalBersih),
                      )
                    ],
                  )) ),),
          ],
        ),
      ),
    );
  }

  var pagetheme = await _myPageTheme(format);
  for (var element in as) {
    double tahunTotalPerbaikan = 0;
    double tahunTotalBersih = 0;
    double tahunTotalOngkos = 0;
    double tahunTotalKeluar = 0;
    double tahunTotalSisa = 0;
for (var listBulananMobil in element.listBulananMobil) {
  
    tahunTotalSisa += listBulananMobil.totalSisa;
    tahunTotalBersih += listBulananMobil.totalBersih;
    tahunTotalKeluar += listBulananMobil.totalKeluar;
    tahunTotalOngkos += listBulananMobil.totalOngkos;
    tahunTotalPerbaikan += listBulananMobil.totalPerbaikan;
}
    document.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
         margin: const pw.EdgeInsets.only(top: 16,bottom: 16,right: 16,left: 48),
        build: ((pw.Context context) {
          return pw.Stack(alignment: pw.Alignment.center, children: [
            pw.Image(asu), pw.Container(
            child: pw.Container(
              decoration: pw.BoxDecoration(border: pw.Border.all()
                  // color: Colors.red.shade600
                  ),
              // elevation:1,
              // color: Colors.white, surfaceTintColor: Colors.grey.shade500,
              // shadowColor: Theme.of(context).colorScheme.primary,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.max,
                  children: [
                    pw.Row(children: [ pw.Padding(
                      padding: const pw.EdgeInsets.only(
                          left: 15.0, top: 7.5, bottom: 7.5),
                      child: pw.Text('${element.namaMobil} - ${element.tahun}',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold)
                          // style: Theme.of(context).textTheme.bodyLarge,
                          ),
                    ),pw.Spacer(),
                              pw.Text(yourDateTime, style: small)
                              ,pw.Text('   ${as.indexOf(element)+1}/${as.length}    ')])
                   ,
          
                    pw.Container(
                      decoration: pw.BoxDecoration(border: pw.Border.all()
                          // color: Theme.of(context).colorScheme.primary,
                          ),
                      padding:
                          const pw.EdgeInsets.only(top: 5, bottom: 5, left: 15),
                      child: pw.Row(
                        children: [
                          pw.Expanded(
                              flex: 4, child: pw.Text('Bulan', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Tarif', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Keluar', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Sisa', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Maintain', style: bold)),
                          pw.Expanded(
                              flex: 7, child: pw.Text('Bersih', style: bold)),
                        ],
                      ),
                    ),
                    ...buildChildren(element.listBulananMobil),
                    pw.Spacer(),
                    element.listBulananMobil.isEmpty
                        ? pw.SizedBox()
                        :  pw.Padding(
                            padding: const pw.EdgeInsets.only(
                                top: 8, bottom: 8, left: 15, right: 20),
                            child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text('Total Ongkos ',
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child:pw.Row(
                      mainAxisAlignment:pw. MainAxisAlignment.spaceBetween,
                      children: [
                   pw.     Text("Rp.",style: small),pw.
                        Text(Rupiah.format2(tahunTotalOngkos), style:small
                                         
                                          )
                      ])
                                      ),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text('Total Keluar ',
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Row(
                      mainAxisAlignment:pw. MainAxisAlignment.spaceBetween,
                      children: [
                   pw.     Text("Rp.",style: small),pw.
                        Text(Rupiah.format2(tahunTotalKeluar), style:small
                                         
                                          )
                      ]),
                                      ),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Text('Total Sisa ',
                                            style: small),
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                        margin: const pw.EdgeInsets.only(
                                            top: 4, bottom: 0),
                                        child: pw.Row(
                      mainAxisAlignment:pw. MainAxisAlignment.spaceBetween,
                      children: [
                   pw.     Text("Rp.",style: small),pw.
                        Text(Rupiah.format2(tahunTotalSisa), style:small
                                         
                                          )
                      ]),
                                      ),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child: pw.Text('Total Maintain',
                                              style: small)),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child:pw.Row(
                      mainAxisAlignment:pw. MainAxisAlignment.spaceBetween,
                      children: [
                   pw.     Text("Rp.",style: small),pw.
                        Text(Rupiah.format2(tahunTotalPerbaikan), style:small
                                         
                                          )
                      ])),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child: pw.Text('Total Bersih ',
                                              style: small)),
                                    ),
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Container(
                                          margin: const pw.EdgeInsets.only(
                                              top: 4, bottom: 0),
                                          child:pw.Row(
                      mainAxisAlignment:pw. MainAxisAlignment.spaceBetween,
                      children: [
                   pw.     Text("Rp.",style: small),pw.
                        Text(Rupiah.format2(tahunTotalBersih), style:small
                                         
                                          )
                      ])),
                                    ),
                                    pw.Expanded(flex: 5, child: pw.SizedBox()),
                                  ],
                                ),
                                pw.Row(
                                  children: [
                                    pw.Expanded(
                                      flex: 9,
                                      child: pw.Divider(
                                        height: 7,
                                      ),
                                    ),
                                    pw.Expanded(flex: 9, child: pw.SizedBox())
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ]), // This trailing comma makes auto-formatting nicer for build methods.
            ),
           )] );
        })));
  }
  // await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => document.save());

  return await document.save();
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  format = format.applyMargin(
      left: 10.0 * PdfPageFormat.cm,
      top: 4.0 * PdfPageFormat.cm,
      right: 2.0 * PdfPageFormat.cm,
      bottom: 2.0 * PdfPageFormat.cm); // );
  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    // buildBackground: (pw.Context context) {
    //   return pw.FullPage(
    //     ignoreMargins: true,
    //     child: pw.Stack(
    //       children: [
    //       pw.Transform.scale(scale: 0.3,child: pw.Positioned(
    //           child: pw.SvgImage(svg: bgShape),
    //           left: 0,
    //           top: 0,
    //         ), ),
    //       pw.Transform.scale(scale: 0.4,child:   pw.Positioned(
    //           child: pw.Transform.rotate(
    //               angle: pi, child: pw.SvgImage(svg: bgShape)),
    //           right: 0,
    //           bottom: 0,
    //         )),
    //       ],
    //     ),
    //   );
    // },
  );
}
