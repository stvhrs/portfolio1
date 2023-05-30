import 'package:flutter/material.dart';
import 'package:cahaya/examples.dart';
import 'package:printing/printing.dart';

class LabaRugi extends StatefulWidget {
 
  final int ropdownValue2 ;final String dropdownValue;final String dropdownValue2;
    final double totalTransaksi ;
  final double totalJualUnit ;
   final double totalNotaJual 
  ;
final double totalPerbaikan;
  final double totalAdministrasi ;
  final double toalBeliUnit ;
  final double totalNotaBeli;

  final double totalPendapatan ;
  final double totalPengeluaran ;
  final double saldoAkhir ;
  final double saldoAwal ; 

   const LabaRugi(
    this. ropdownValue2 ,this. dropdownValue,this. dropdownValue2,
    this. totalTransaksi ,
  this. totalJualUnit ,
   this. totalNotaJual 
  ,
this.totalPerbaikan,
  this. totalAdministrasi ,
  this. toalBeliUnit ,
  this. totalNotaBeli,

  this. totalPendapatan ,
  this. totalPengeluaran ,
  this. saldoAkhir ,
  this. saldoAwal 
  );

  @override
  State<LabaRugi> createState() => _LabaRugiState();
}

class _LabaRugiState extends State<LabaRugi> {
  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            primaryColor: const Color.fromARGB(255, 59, 59, 65)),
        child: PdfPreview(
          loadingWidget: const Text('Loading...'),
          onError: (context, error) => const Text('Error...'),
          maxPageWidth: 700,
          pdfFileName: 'Laporan Laba Rugi',
          canDebug: false,
          build: (format) => examples4[0].builder(
            format,
            widget. ropdownValue2 ,widget. dropdownValue,widget. dropdownValue2,
    widget. totalTransaksi ,
  widget. totalJualUnit ,
   widget. totalNotaJual 
  ,
widget.totalPerbaikan,
  widget. totalAdministrasi ,
  widget. toalBeliUnit ,
  widget. totalNotaBeli,

  widget. totalPendapatan ,
  widget. totalPengeluaran ,
  widget. saldoAkhir ,
  widget. saldoAwal 
          ),
          onPrinted: _showPrintedToast,
          canChangeOrientation: false,
          canChangePageFormat: false,
          onShared: _showSharedToast,
        ),
      ),
    );
  }
}
