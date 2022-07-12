library flutter_application_1.fetchListNotaTindakan;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future fetchListNotaTindakan(pTgl) async {
  final response = await http.post(Uri.parse(apiUrl + "akuntan_v_tindakan.php"), body: ({"tgl_transaksi": pTgl.toString().substring(0, 7)}));
  if (response.statusCode == 200) {
    print('fetchListNotaObat: ${response.body} | pTgl: ${pTgl.toString().substring(0, 7)}');
    return jsonDecode(response.body);
  } else {
    print(response.body);
    throw Exception('Failed to read API');
  }
}
