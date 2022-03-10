library flutter_application_1.fetch_laba_kotor;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class AkuntanVLabaKotor {
  var laba_kotor;
  AkuntanVLabaKotor({this.laba_kotor});
  // untuk convert dari jSon
  factory AkuntanVLabaKotor.fromJson(Map<String, dynamic> json) {
    return new AkuntanVLabaKotor(
      laba_kotor: json['laba_kotor'],
    );
  }
}

Future<String> fetchDataVLabaKotor(pTglCatat) async {
  // print('pTglCatat $pTglCatat');
  final response =
      await http.post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_laba_kotor.php"), body: {
    'tgl_laba_kotor': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
