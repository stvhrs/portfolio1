import 'package:flutter/material.dart';
import 'package:cahaya/examples.dart';
import 'package:cahaya/models/history_saldo.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

class MutasiPrint extends StatefulWidget {
  final List<HistorySaldo> list;

  const MutasiPrint(
    this.list,
  );

  @override
  State<MutasiPrint> createState() => _MutasiPrintState();
}

class _MutasiPrintState extends State<MutasiPrint> {
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
          pdfFileName: 'Mutasi',
          canDebug: false,
          build: (format) => examples3[0].builder(
            format,
            widget.list,Provider.of<ProviderData>(context,listen: false).totalSaldo
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
