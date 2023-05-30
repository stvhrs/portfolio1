import 'package:flutter/material.dart';
import 'package:cahaya/examples.dart';
import 'package:cahaya/models/history_saldo.dart';
import 'package:cahaya/models/history_saldo2.dart';
import 'package:cahaya/models/kas_tahun.dart';
import 'package:printing/printing.dart';

class PrintDynamic extends StatefulWidget {
  final List<HistorySaldo2> list;

  const PrintDynamic(
    this.list,
  );

  @override
  State<PrintDynamic> createState() => _PrintDynamicState();
}

class _PrintDynamicState extends State<PrintDynamic> {
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
          pdfFileName: widget.list[0].sumber,
          canDebug: false,
          build: (format) => printAllx[0].builder(
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