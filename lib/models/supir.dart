class Supir {
String id;
  String nama_supir;
  String nohp_supir;
bool delted;
  Supir(this.id,this.nama_supir, this.nohp_supir,this.delted);

  factory Supir.fromMap(Map<String, dynamic> data) {

    return Supir(data['id_supir'], data['nama_supir'], data['no_hp'],data['terhapus']=="true");
  }
}
