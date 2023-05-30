import 'dart:async';
import 'dart:typed_data';

import 'package:cahaya/models/history_saldo2.dart';
import 'package:cahaya/models/keuangan_bulanan.dart';
import 'package:cahaya/models/rekap_model.dart';
import 'package:cahaya/print_all.dart';
import 'package:cahaya/print_bulanan.dart';
import 'package:cahaya/print_laba.dart';
import 'package:cahaya/print_mutasi.dart';
import 'package:cahaya/print_reekap.dart';
import 'package:cahaya/print_tahunan.dart';
import 'package:cahaya/print_unit.dart';
import 'package:pdf/pdf.dart';

import 'models/history_saldo.dart';
import 'models/kas_tahun.dart';

const examples = [
  Example(generateResume, true),
];
const printAllx = [
  PrintAll(printAll, true),
];
const examples3 = [
  Example3(generateResume3, true),
];
const examples2 = [
  Example2(generateResume2, true),
];
const examples4 = [
  Example4(generateResume4, true),
];
const examples10 = [
  PrintUnit(printUnit, true),
];const rekapTahun = [
  Rekap(rekap, true),
];class Rekap {
  const Rekap(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData11 builder;

  final bool needsData;
}typedef LayoutCallbackWithData11 = Future<Uint8List> Function(
    PdfPageFormat pageFormat,List<RekapModel> list, double tahunTotalOngkos, double tahunTotalKeluar, double tahunTotalSisa,
              double  tahunTotalPerbaikan,double tahunTotalBersih  );

class PrintUnit {
  const PrintUnit(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData10 builder;

  final bool needsData;
}typedef LayoutCallbackWithData10 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<HistorySaldo2> list, );

class PrintAll {
  const PrintAll(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData9 builder;

  final bool needsData;
}

typedef LayoutCallbackWithData9 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<HistorySaldo2> list, );


class Example3 {
  const Example3(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData3 builder;

  final bool needsData;
}

typedef LayoutCallbackWithData3 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<HistorySaldo> asu, double asx);


  
typedef LayoutCallbackWithData4 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, int ropdownValue2 ,String dropdownValue,String dropdownValue2,
    double totalTransaksi ,
  double totalJualUnit ,
   double totalNotaJual 
  ,
 double totalPerbaikan,
  double tahunMaintain ,
  double toalBeliUnit ,
  double totalNotaBeli,

  double totalPendapatan ,
  double totalPengeluaran ,
  double saldoAkhir ,
  double saldoAwal , );

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<KeuanganBulanan> asu);

typedef LayoutCallbackWithData2 = Future<Uint8List> Function(
    PdfPageFormat pageFormat, List<KasModel> asu);

class Example {
  const Example(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData builder;

  final bool needsData;
}

class Example2 {
  const Example2(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData2 builder;

  final bool needsData;
}

class Example4 {
  const Example4(this.builder, [this.needsData = false]);

  final LayoutCallbackWithData4 builder;

  final bool needsData;
}
