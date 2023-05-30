class Perbaikan {
  String id;
  String id_mobil;
  String mobil;
  String jenis;
  double harga;
  String tanggal;
  String keterangan;
  bool adminitrasi;
  Perbaikan(this.id, this.id_mobil, this.mobil, this.jenis, this.harga,
      this.tanggal, this.keterangan,this.adminitrasi);
  factory Perbaikan.fromMap(Map<String, dynamic> data) {
    //  "id_perbaikan": "23",
    //             "id_mobil": "4",
    //             "jenis_p": "cccc",
    //             "harga_p": "2222333",
    //             "ket_p": "Keterangan",
    //             "tgl_p": "2023-02-02T20:06:32.561"
    return Perbaikan(
        data['id_perbaikan'],
        data['id_mobil'],
       data['plat_mobil'],
        data['jenis_p'],
        double.parse(data['harga_p']),
        data['tgl_p'],
        data['ket_p'],data['administrasi']=="true");
  }
}
