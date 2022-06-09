import 'dart:convert';

import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pemilik/tambah_pegawai/model/pegawai_model.dart';
import 'package:http/http.dart' as http;

Future<String> FetchInfoPegawai() async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.get(
    Uri.parse(apiUrl + "pemilik_v_pegawai.php"),
  );
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
