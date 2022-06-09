import 'dart:convert';

import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> PostAddPegawai(_username, _sandi, _nama, _tlp, _alamat) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response =
      await http.post(Uri.parse(apiUrl + "pemilik_add_pegawai.php"), body: {
    'username': _username,
    'sandi': _sandi,
    'nama': _nama,
    'tlp': _tlp,
    'alamat': _alamat
  });
  if (response.statusCode == 200) {
    // print('200: ${jsonDecode(response.body)}');
    var hasilGet = jsonDecode(response.body);
    // print(hasilGet['data']);
    // for (var item in hasilGet['data']) {
    //   print(item);
    // }
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
