import 'dart:convert';
  import 'package:crypto/crypto.dart' as s;

String generateMd5(String input) {

var appleInBytes = utf8.encode(input);
String value = s.sha512.convert(appleInBytes).toString();
//print(value.toString());
  return value;
}