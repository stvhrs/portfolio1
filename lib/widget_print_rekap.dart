import 'package:cahaya/models/rekap_model.dart';
import 'package:cahaya/pages/rekap_tile.dart';
import 'package:flutter/material.dart';
import 'package:cahaya/examples.dart';
import 'package:cahaya/models/history_saldo.dart';
import 'package:cahaya/models/history_saldo2.dart';
import 'package:cahaya/models/kas_tahun.dart';
import 'package:cahaya/print_unit.dart';
import 'package:printing/printing.dart';

class Rekapitulasi extends StatefulWidget {
  final List<RekapModel> list;
final double tahunTotalOngkos; 
final double tahunTotalKeluar;
final double tahunTotalSisa;
            final  double  tahunTotalPerbaikan;
            final double tahunTotalBersih;
  const Rekapitulasi(
    this.list,this.tahunTotalOngkos,this.tahunTotalKeluar,this.tahunTotalSisa,this.tahunTotalPerbaikan,this.tahunTotalBersih
  );

  @override
  State<Rekapitulasi> createState() => _RekapitulasiState();
}

class _RekapitulasiState extends State<Rekapitulasi> {
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
          pdfFileName: "Rekap Tahunan",
          canDebug: false,
          build: (format) => rekapTahun[0].builder(
            format,
            widget.list,widget.tahunTotalOngkos,widget.tahunTotalKeluar,widget.tahunTotalSisa,widget.tahunTotalPerbaikan,widget.tahunTotalBersih
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
