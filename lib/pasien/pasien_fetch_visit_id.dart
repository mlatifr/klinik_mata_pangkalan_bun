library flutter_application_1.pasien_fetch_visit_id;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

var visitIdPasien;
Future<String> fetchDataVisitId(pUserId, pTglCatat) async {
  print('fetchDataVisitId: $pUserId | $pTglCatat');
  final response =
      await http.post(Uri.parse(apiUrl + "pasien_v_visit_id_now.php"), body: {
    'user_id': pUserId.toString(),
    'tgl_visit': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVisitId: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
