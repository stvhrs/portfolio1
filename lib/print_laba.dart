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
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'helper/rupiah_format.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor lightRed = PdfColor.fromInt(0xf593a0);
const PdfColor lightblue = PdfColor.fromInt(0xFFBBDEFB);
const PdfColor grey = PdfColor.fromInt(0xededed);
const sep = 120.0;

Future<Uint8List> generateResume4(
  PdfPageFormat format,
  int ropdownValue2,
  String dropdownValue,
  String dropdownValue2,
  double totalTransaksi,
  double totalJualUnit,
  double totalNotaJual,double totalPerbaikan,
  double totalAdministrasi,
  double toalBeliUnit,
  double totalNotaBeli,
  double totalPendapatan,
  double totalPengeluaran,
  double saldoAkhir,
  double saldoAwal,
) async {
  DateTime dateTime = DateTime.parse(DateTime.now().toIso8601String());
  String yourDateTime = DateFormat('HH:mm dd-MM-yyyy').format(dateTime);
  final document = pw.Document();
  pw.TextStyle bold =
      pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10);
  pw.TextStyle light = const pw.TextStyle(fontSize: 10);
  pw.ImageProvider asu = pw.MemoryImage(
    (await rootBundle.load('images/title.png')).buffer.asUint8List(),
  );

  document.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
       margin: const pw.EdgeInsets.only(top: 16,bottom: 16,right: 16,left: 48),
      build: ((pw.Context context) {
        return pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          padding: const pw.EdgeInsets.all(1),
          child:pw. Container(
              padding: const pw. EdgeInsets.all(0),
            
              child: pw.Container(
               
               
                child:pw. Column(
                  children: [
                   pw. Padding(
                      padding: const pw. EdgeInsets.all(8.0),
                      child:pw. Center(
                          child:pw. Column(children: [
                       pw. Image(asu),
                       pw. Text(
                          'Laporan Kas ' "Periode " +
                              ropdownValue2.toString() +
                              " " +
                              dropdownValue +
                              " - " +
                              dropdownValue2,
                          style:  pw. TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 17),
                        ),
                      ])),
                    ),
                   pw. Container(
                      color: lightblue,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Saldo Awal",
                                style: bold,
                              )),pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                     
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(saldoAwal),
                                            style: light)
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    ),
                   pw. Container(
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Pemasukan :",
                                style: bold,
                              )),
                        ],
                      ),
                    ),
                   pw. Container(
                      color:grey,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Transaksi",
                                style: bold,
                              )),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                 
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(
                                            Rupiah.format2(
                                              totalTransaksi,
                                            ),
                                            style: light)
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    ),
                   pw. Container(
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Jual Unit",
                                style: bold,
                              )),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(
                                          Rupiah.format2(totalJualUnit),
                                          style: light,
                                        )
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    ),
                   pw. Container(
                      color:grey,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Nota Pemasukan",
                                style: bold,
                              )),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(totalNotaJual),
                                            style: light)
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    ),
                   pw. Container(
                      color: lightGreen,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Total Pemasukan",
                                style: bold,
                              )),pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                 
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(totalPendapatan),
                                            style: light)
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    ),
                   pw. Container(
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Pengeluaran :",
                                style: bold,
                              )),
                        ],
                      ),
                    ),
                   pw. Container(
                      color:grey,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 3,
                              child:pw. Text(
                                "Administrasi",
                                style: bold,
                              )),pw.Expanded(flex: 4,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                  
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(totalAdministrasi),
                                            style: light)
                                      ]))),
                        ],
                      ),
                    ),
                   pw. Container(
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 3,
                              child:pw. Text(
                                "Perbaikan",
                                style: bold,
                              )),pw.Expanded(flex: 4,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                  
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(totalPerbaikan),
                                            style: light)
                                      ]))),
                        ],
                      ),
                    ),
                   pw. Container(
                      color:grey,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 3,
                              child:pw. Text(
                                "Beli Unit",
                                style: bold,
                              )),pw.Expanded(flex: 4,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                  
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(toalBeliUnit),
                                            style: light)
                                      ]))),
                        ],
                      ),
                    ),
                   pw. Container(
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(
                              flex: 3,
                              child:pw. Text(
                                "Nota Pengeluaran",
                                style: bold,
                              )),pw.Expanded(flex: 4,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                  
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(totalNotaBeli),
                                            style: light)
                                      ]))),
                        ],
                      ),
                    ),
                   pw. Container(
                      color: lightRed,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Total Pengeluaran",
                                style: bold,
                              )),
                         pw. Expanded(
                              child:pw. Container(
                                  
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(totalPengeluaran),
                                            style: light)
                                      ]))),
                        ],
                      ),
                    ),
                   pw. Container(
                      color:grey,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Laba Rugi",
                                style: bold,
                              )),pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                    
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(
                                            Rupiah.format2(totalPendapatan +
                                                totalPengeluaran),
                                            style: light)
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    ),
                   pw. Container(
                      color: lightblue,
                      padding: const pw. EdgeInsets.all(4),
                      child:pw. Row(
                        children: [
                         pw. Expanded(
                              flex: 4,
                              child:pw. Text(
                                "Saldo Akhir",
                                style: bold,
                              )),pw.Expanded(flex: 1,child: pw.SizedBox()),
                         pw. Expanded(flex: 2,
                              child:pw. Container(
                                
                                  child:pw. Row(
                                      mainAxisAlignment:
                                        pw.  MainAxisAlignment.spaceBetween,
                                      children: [
                                       pw. Text(
                                          "Rp.",
                                          style: light,
                                        ),
                                       pw. Text(Rupiah.format2(saldoAkhir),
                                            style: light)
                                      ]))),pw.Expanded(flex: 3,child: pw.SizedBox()),
                        ],
                      ),
                    )]))));
      })));

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
