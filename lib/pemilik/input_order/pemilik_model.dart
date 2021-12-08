library flutter_application_1.pemilik_model;

// import 'dart:async';
// // ignore: unused_import
// import 'dart:convert';
// import 'package:flutter_application_1/main.dart';
// import 'package:http/http.dart' as http;

// List<ApotekerrVListObat> aVLOs = [];
// List<ApotekerVKeranjangObatDokter> aVKODrs = [];
// List<ApotekerVKeranjangObat> aVKOs = [];
List<PemilikInputResepList> ListKeranjangObat = [];

class PemilikInputResepList {
  var harga_beli, harga_jual, jumlah_order, obatNama;
  PemilikInputResepList(
      {this.harga_beli, this.harga_jual, this.obatNama, this.jumlah_order});
}
// Future<String> fetchDataApotekerInputRspVst(
//     pVisitId, pUserIdApoteker, pTglPenulisanResep) async {
//   // print(
//   //     'fetchDataApotekerInputRspVst: $pVisit_id | $pUser_id_apoteker | $pTgl_penulisan_resep');
//   final response = await http
//       .post(Uri.parse(apiUrl + "apoteker_input_resep_visit.php"), body: {
//     'visit_id': pVisitId.toString(),
//     'user_id_apoteker': pUserIdApoteker.toString(),
//     'tgl_penulisan_resep': pTglPenulisanResep.toString()
//   });
//   if (response.statusCode == 200) {
//     print('fetchDataApotekerInputRspVst: ${response.body}');
//     return response.body;
//   } else {
//     // print('else: ${response.body}');
//     throw Exception('Failed to read API');
//   }
// }

// Future<String> fetchDataApotekerVListObat(pNamaObat) async {
//   // print('final: $pVisitId | $pTdkId | $pMtSisi');
//   final response = await http.post(
//       Uri.parse(apiUrl + "apoteker_v_list_obat.php"),
//       body: {'nama_obat': pNamaObat.toString()});
//   if (response.statusCode == 200) {
//     // print('200: ${response.body}');
//     return response.body;
//   } else {
//     // print('else: ${response.body}');
//     throw Exception('Failed to read API');
//   }
// }

// Future<String> fetchDataApotekerInputResepObat(
//     pRspAptkrId, pObtId, pDosis, pJumlah, pVisitId) async {
//   // print('final: $pObtId | $pDosis | $pJumlah | $pVisitId');
//   final response = await http
//       .post(Uri.parse(apiUrl + "apoteker_input_resep_has_obat.php"), body: {
//     "resep_apoteker_id": pRspAptkrId.toString(),
//     "obat_id": pObtId.toString(),
//     "dosis": pDosis.toString(),
//     "jumlah": pJumlah.toString(),
//     "visit_id": pVisitId.toString(),
//   });
//   if (response.statusCode == 200) {
//     // print('fetchDataApotekerInputResepObat: ${response.body}');
//     return response.body;
//   } else {
//     print('else fetchDataApotekerInputResepObat: ${response.body}');
//     throw Exception('Failed to read API');
//   }
// }

// Future<String> fetchDataApotekerKeranjangObatDokter(pVisitId) async {
//   // print('final:$pVisitId');
//   final response =
//       await http.post(Uri.parse(apiUrl + "apoteker_v_rsp_dr.php"), body: {
//     "visit_id": pVisitId.toString(),
//   });
//   if (response.statusCode == 200) {
//     print('200: ${response.body}');
//     return response.body;
//   } else {
//     // print('else: ${response.body}');
//     throw Exception('Failed to read API');
//   }
// }

// Future<String> fetchDataApotekerVKeranjangResepApotekerId(pVisitId) async {
//   // print('final:$pVisitId');
//   final response = await http.post(
//       Uri.parse(apiUrl + "apoteker_v_keranjang_resep_obat_apoteker.php"),
//       body: {
//         "visit_id": pVisitId.toString(),
//       });
//   if (response.statusCode == 200) {
//     print('apoteker_v_keranjang_resep_obat 200: ${response.body}');
//     return response.body;
//   } else {
//     // print('else: ${response.body}');
//     throw Exception('Failed to read API');
//   }
// }
