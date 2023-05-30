import 'package:intl/intl.dart';

class Rupiah {
  static String format(double i) {
    return NumberFormat.currency(
            locale: "id_ID", decimalDigits: 0, symbol: 'Rp ')
        .format(i)
        .toString()
        .replaceAll('-', '');
  }

  static String format2(double i) {
    return NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: '')
        .format(i)
        .replaceAll('-', '');
  }

  static double parse(String s) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
        .parse(s)
        .toDouble();
  }
}
