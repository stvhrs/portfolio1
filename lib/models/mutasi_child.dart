class MutasiChild {
  double qty;
  double harga;
double total;
  String keterangan;

  MutasiChild(
    this.qty,
    this.harga,
    this.keterangan,this.total
  );
  
  factory MutasiChild.fromMap(Map<String, dynamic> data) {
    return MutasiChild(
    double.parse( data['qty'].toString()) ,
    double.parse( data['harga'].toString()) ,
      data['keterangan'],double.parse( data['total'].toString())
    );
  }
}
