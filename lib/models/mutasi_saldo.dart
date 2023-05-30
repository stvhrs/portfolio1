import 'package:cahaya/models/mutasi_child.dart';

class MutasiSaldo {
  String id;
  double harga;

  String tanggal;
  bool pendapatan;
  String keterangan;
String nota;
  MutasiSaldo(this.id, this.harga, this.tanggal,
      this.pendapatan, this.keterangan,this.nota);
  factory MutasiSaldo.fromMap(
      Map<String, dynamic> data, ) {
    return MutasiSaldo(
        data["id_mutasi"],
        double.parse(data['total_mutasi']),
       
        data['tanggal_mutasi'],
        data['pendapatan_mutasi'] == "true",
        data['keterangan_mutasi'],data["nota"]??"");
  }
}
