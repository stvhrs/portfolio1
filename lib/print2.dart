import 'package:flutter/material.dart';
import 'package:cahaya/examples.dart';
import 'package:cahaya/models/kas_tahun.dart';
import 'package:printing/printing.dart';

class TahunPrint extends StatefulWidget {
  final List<KasModel> list;

  const TahunPrint(
    this.list,
  );

  @override
  State<TahunPrint> createState() => _TahunPrintState();
}

class _TahunPrintState extends State<TahunPrint> {
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
          pdfFileName: 'Laporan_Tahunan',
          canDebug: false,
          build: (format) => examples2[0].builder(
            format,
            widget.list,
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
