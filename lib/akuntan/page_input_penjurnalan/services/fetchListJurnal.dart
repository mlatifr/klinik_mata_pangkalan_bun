library flutter_application_1.fetchListJurnal;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future fetchListJurnal(pTgl) async {
  final response = await http.post(Uri.parse(apiUrl + "akuntan_v_jurnal.php"),
      body: ({"tgl_transaksi": pTgl.toString()}));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print(response.body);
    throw Exception('Failed to read API');
  }
}
