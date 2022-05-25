library flutter_application_1.get_listCoA;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/akuntan/chartOfAccount/model_listAkun.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

// Future fetchAkuntanCoA() async {
//   final response = await http.post(
//     Uri.parse(apiUrl + "akuntan_v_dftr_akun.php"),
//   );
//   if (response.statusCode == 200) {
//     // print(response.body);
//     return jsonDecode(response.body);
//   } else {
//     print(response.body);
//     throw Exception('Failed to read API');
//   }
// }

Future fetchAkuntanCoA() async {
  final response = await http.post(
    Uri.parse(apiUrl + "akuntan_v_dftr_akun.php"),
  );
  if (response.statusCode == 200) {
    // print(response.body);
    return jsonDecode(response.body);
  } else {
    print(response.body);
    throw Exception('Failed to read API');
  }
}

List<DataCoA> listNamaAkun = [
  // DataCoA(id: 001, no: 001, nama: 'kas1', enableEditing: false),
  // DataCoA(id: 002, no: 002, nama: 'kas2', enableEditing: false),
  // DataCoA(id: 003, no: 003, nama: 'kas3', enableEditing: false),
  // DataCoA(id: 004, no: 004, nama: 'kas4', enableEditing: false),
  // DataCoA(id: 005, no: 005, nama: 'kas5', enableEditing: false),
  // DataCoA(id: 006, no: 006, nama: 'kas6', enableEditing: false),
  // DataCoA(id: 007, no: 007, nama: 'kas7', enableEditing: false),
  // DataCoA(id: 008, no: 008, nama: 'kas8', enableEditing: false),
  // DataCoA(id: 009, no: 009, nama: 'kas9', enableEditing: false),
  // DataCoA(id: 010, no: 010, nama: 'kas10', enableEditing: false),
  // DataCoA(id: 011, no: 011, nama: 'kas11', enableEditing: false),
  // DataCoA(id: 012, no: 012, nama: 'kas12', enableEditing: false),
  // DataCoA(id: 013, no: 013, nama: 'kas13', enableEditing: false),
];
Future AkuntanBacaDataCoa() async {
  listNamaAkun.clear();
  Future dataCoa = fetchAkuntanCoA();
  dataCoa.then((value) {
    Map json = jsonDecode(value);
    for (var i in json['data']) {
      DataCoA dataCoA = DataCoA.fromJson(i);
      listNamaAkun.add(dataCoA);
      print("listNamaAkun.length: ${listNamaAkun.length}");
    }
  });
  return listNamaAkun;
}
