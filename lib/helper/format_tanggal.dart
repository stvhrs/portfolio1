import 'package:intl/intl.dart';

class FormatTanggal {
  static formatTanggal(String tgl) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(tgl));
  }
}
