import 'keuangan_bulanan.dart';

class KasModel {
  String namaMobil;
  List<KeuanganBulanan> listBulananMobil;
  double totalSisa;
double totalKeluar;
double totalOngkos;

double totalPerbaikan;

  String tahun;

  KasModel(this.namaMobil, this.listBulananMobil, this.totalSisa,
      this.totalKeluar,this.totalOngkos, this.totalPerbaikan, this.tahun);
}
