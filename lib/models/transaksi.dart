class Transaksi {
  String tanggalBerangkat;

  String supir;
  String mobil;
  String tujuan;
  String keterangan;
  double keluar;
  double ongkos;
  double sisa;
  String id;
  String id_supir;
  String id_mobil;
  String keterangan_mobill;
String sender;
  Transaksi(
    this.id,
    this.id_supir,
    this.id_mobil,
    this.tanggalBerangkat,
    this.keterangan,
    this.supir,
    this.mobil,
    this.keterangan_mobill,
    this.tujuan,
    this.keluar,
    this.ongkos,
    this.sisa,this.sender
  );

  factory Transaksi.  fromMap(Map<String, dynamic> data) {
    return Transaksi(
      data['id_transaksi'] ,
      data['id_supir'] ?? "X",
      data['id_mobil'] ?? "X",
     
      data['tanggal'] ??
       DateTime.now().toIso8601String(),
      data['ket_transaksi'] ?? "X",
      data['nama_supir'] ?? "X",
      data['plat_mobil'] ?? "X",
       data['ket_mobil'] ?? "X",
      data['tujuan'] ?? "X",
      double.parse(data['keluar']),
      double.parse(data['ongkosan']),
      double.parse(data['sisa'],),data['sender']
    );
  }

  
}
