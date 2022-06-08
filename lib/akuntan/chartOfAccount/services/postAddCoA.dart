library flutter_application_1.postAddCoA;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future postAddCoA(String no, String nama) async {
  final response = await http.post(
      Uri.parse(apiUrl + "akuntan_add_akunCoA.php"),
      body: {'no': no, 'nama': nama});
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    // print(response.body);
    throw Exception('Failed to read API');
  }
}
