library flutter_application_1.fetchCoA;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/akuntan/chartOfAccount/controllers/controller_CoA.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future fetchAkuntanCoA() async {
  print('cek fetchAkuntanCoA');
  final _CoAController = Get.put(listCoAController());
  final response = await http.post(
    Uri.parse(apiUrl + "akuntan_v_dftr_akun.php"),
  );
  if (response.statusCode == 200) {
    // print(response.body);
    var hasilJson = jsonDecode(response.body);
    _CoAController.listNamaAkun.clear();
    for (var i in hasilJson['data']) {
      var jsonRslt = DataCoA.fromJson(i);
      _CoAController.listNamaAkun.add(jsonRslt);
    }
    return jsonDecode(response.body);
  } else {
    print(response.body);
    throw Exception('Failed to read API');
  }
}
