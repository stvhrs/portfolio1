import 'dart:convert';
import 'dart:developer';
import 'package:cahaya/models/jual_beli_mobil.dart';
import 'package:cahaya/models/mobil.dart';
import 'package:cahaya/models/mutasi_child.dart';
import 'package:cahaya/models/supir.dart';
import 'package:cahaya/models/transaksi.dart';
import 'package:cahaya/models/user.dart';
import 'package:cahaya/services/datauku.dart';
import 'package:http/http.dart' as http;
import '../models/mutasi_saldo.dart';
import '../models/perbaikan.dart';



class Service {
  static Future<List<MutasiSaldo>> getAllMutasiSaldo() async {
    List<MutasiSaldo> data = [];
   
  

    for (Map<String, dynamic> element in TRANSAKSILAIN) {
      log(element.toString());

      data.add(MutasiSaldo.fromMap(
        element,
      ));
    }

    return data;
  }

  static Future<List<Transaksi>> getAllTransaksi() async {
    List<Transaksi> data = [];
    try {
  

      for (Map<String, dynamic> te in TRANSAKSI) {
        data.add(Transaksi.fromMap(te));
      }

      return data;
    } catch (e) {
      return data;
    }
  }

  static Future<List<User>> getUser() async {
    try {
      List<User> data = [];
   
      for (Map<String, dynamic> element in []) {
        data.add(User.fromMap(element));
      }
      return data;
    } catch (e) {
      return [];
    }
  }

  static Future<User?> getUserId(String id) async {
    try {
     
    } catch (e) {
      return null;
    }
  }

  static Future<List<Supir>> getAllSupir() async {
    List<Supir> data = [];
  
    for (Map<String, dynamic> element in SUPIR) {
      data.add(Supir.fromMap(element));
    }
    return data;
  }

  static Future<List<Perbaikan>> getAllPerbaikan() async {
    List<Perbaikan> data = [];
   
    for (Map<String, dynamic> element in PERBAIKAN) {
      data.add(Perbaikan.fromMap(element));
    }
    return data;
  }

  static Future<List<JualBeliMobil>> getAlljualBeli() async {
   
    List<JualBeliMobil> data = [];
    for (Map<String, dynamic> element in [{"id_jb":"14","id_mobil":"23","plat_mobil":"L8631UH","ket_mobil":"0","harga_jb":"245000000","ket_jb":"0","tgl_jb":"2023-02-06T00:00:00.000","jualOrBeli":"false"}]) {
      data.add(JualBeliMobil.fromMap(element));
    }
    return data;
  }

  static Future<List<Mobil>> getAllMobil(List<Perbaikan> list) async {
   

    List<Mobil> data = [];
    for (Map<String, dynamic> te in [{"id_mobil":"1","plat_mobil":"AE9899US","ket_mobil":"Head","terjual":"false"},{"id_mobil":"2","plat_mobil":"B9446UEK","ket_mobil":"Head","terjual":"false"},{"id_mobil":"3","plat_mobil":"R1413SK","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"4","plat_mobil":"DA8937TAO","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"5","plat_mobil":"DA8395TPF","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"6","plat_mobil":"DA8124TAP","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"7","plat_mobil":"DA8397TPF","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"8","plat_mobil":"H1910FA","ket_mobil":"HEAD","terjual":"false"},{"id_mobil":"9","plat_mobil":"L9201UQ","ket_mobil":"HEAD","terjual":"false"},{"id_mobil":"10","plat_mobil":"H8895AO","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"11","plat_mobil":"DA8316TAO","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"12","plat_mobil":"DA8976TAL","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"13","plat_mobil":"DA1599TO","ket_mobil":"HEAD","terjual":"false"},{"id_mobil":"14","plat_mobil":"DA8146CR","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"15","plat_mobil":"DA8147CR","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"16","plat_mobil":"B9879FEU","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"17","plat_mobil":"L9641UL","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"18","plat_mobil":"B9203JZ","ket_mobil":"HEAD","terjual":"false"},{"id_mobil":"19","plat_mobil":"AE9901US","ket_mobil":"HEAD","terjual":"false"},{"id_mobil":"21","plat_mobil":"K8447S","ket_mobil":"TRONTON","terjual":"true"},{"id_mobil":"22","plat_mobil":"R1879BK","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"23","plat_mobil":"L8631UH","ket_mobil":"0","terjual":"true"},{"id_mobil":"27","plat_mobil":"L8014UH","ket_mobil":"TONTON","terjual":"false"},{"id_mobil":"28","plat_mobil":"DA8456TPF","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"35","plat_mobil":"DA8457TPF","ket_mobil":"TRONTON","terjual":"false"},{"id_mobil":"36","plat_mobil":"L9968UV","ket_mobil":"HEAD","terjual":"false"}]) {
      List<Perbaikan> listPerbaikan = list
          .where((element) =>
              (te['plat_mobil'] as String).trim() == element.mobil.trim())
          .toList();
      data.add(Mobil.fromMap(te, listPerbaikan));
    }
    return data;
  }

  static Future<Supir?> postSupir(Map<String, dynamic> data) async {
    try {
      // final response = await http.post(
      //   body: data,
      //   Uri.parse(
      //     '$base/supir',
      //   ),
      // );

      // if (response.body.isNotEmpty) {
      //   return Supir.fromMap(json.decode(response.body)["0"]["supir"][0]);
      // } else {
      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }

  static Future<Supir?> updateSupir(Map<String, dynamic> data) async {
    try {
      // final response = await http.put(
      //   body: data,
      //   Uri.parse(
      //     '$base/supir',
      //   ),
      // );

      // if (response.body.isNotEmpty) {
      //   return Supir.fromMap(json.decode(response.body)["0"]);
      // } else {
      //   return null;
      // }
    } catch (e) {
      return null;
    }
  }

  static Future<String> deleteSupir(String data) async {
    try {
   return '';
    } catch (e) {
      return '';
    }
  }

  static Future<User?> postUser(Map<String, dynamic> data) async {
    try {
    return null;
    } catch (e) {
      return null;
    }
  }

  static Future<User?> updatUser(Map<String, dynamic> data) async {
    try {
      
    } catch (e) {
      return null;
    }
  }

  static Future<String> deleteUser(String data) async {
    try {
     return '';
    } catch (e) {
      return '';
    }
  }

  static Future<Mobil?> postMobil(Map<String, dynamic> data) async {
    try {
    
    } catch (e) {
      return null;
    }
  }

  static Future<Mobil?> updateMobil(Map<String, dynamic> data) async {
    try {
   
    } catch (e) {
      return null;
    }
  }

  static Future<Mobil?> deleteMobil(Map<String, dynamic> data) async {
    data["terjual"] = "true";
    try {
    
    } catch (e) {
      return null;
    }
  }

  static Future<Perbaikan?> postPerbaikan(Map<String, dynamic> data) async {
    try {
     
    } catch (e) {
      return null;
    }
  }

  static Future<Perbaikan?> updatePerbaikan(Map<String, dynamic> data) async {
    try {
    
    } catch (e) {
      return null;
    }
  }

  static Future<String?> deletePerbaikan(String data) async {
   

   
  
      return null;
    
  }

  static Future<Transaksi?> postTransaksi(Map<String, dynamic> data) async {
    try {
    
    } catch (E) {
      print(E.toString());
      return null;
    }
  }

  static Future<Transaksi?> updateTransaksi(Map<String, dynamic> data) async {
    try {
     
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<String?> deleteTransaksi(String data) async {
    
   
      return null;
   
      return data;
    
  }

  static Future<JualBeliMobil?> postJB(Map<String, dynamic> data) async {
    try {
      Mobil? mobil;
      if (data["jualOrBeli"] == "false") {
        mobil = await updateMobil({
          "id_mobil": data["id_mobil"],
          'plat_mobil': data["plat_mobil"],
          "ket_mobil": data["ket_mobil"],
          "terjual": "true"
        });
        if (mobil == null) {
          return null;
        }
      } else {
        mobil = await postMobil({
          'plat_mobil': data["plat_mobil"],
          "ket_mobil": data["ket_mobil"],
          "terjual": "false"
        });
        if (mobil == null) {
          return null;
        }
      }

      data["id_mobil"] = mobil.id;

     
      // if (json.decode(response.body)['status'] == "false") {
      //   log("tidak boleh sama");
      // }
     
    } catch (E) {
      print(E.toString());
      return null;
    }
  }

  static Future<JualBeliMobil?> updateJb(Map<String, dynamic> data) async {
    try {
    
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<MutasiSaldo?> postMutasi(Map<String, dynamic> mutasi) async {
    try {
    
    } catch (E) {
      log(E.toString());
      return null;
    }
  }

  static Future<MutasiSaldo?> updateMutasi(Map<String, dynamic> mutasi) async {
    try {
   
    } catch (E) {
      log(E.toString());
      return null;
    }
  }

  static Future<String?> deleteMutasi(String data) async {
    try {
   
    
    } catch (e) {
      return null;
    }
  }
}
