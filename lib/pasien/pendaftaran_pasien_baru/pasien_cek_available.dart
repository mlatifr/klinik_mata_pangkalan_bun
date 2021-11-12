library flutter_application_1.pasien_cek_available;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

// List<AkuntanVDftrAkun> AkntVDftrAkns = [];
// List<String> DebetKredit = ['debet', 'kredit'];
// var valIdAkun, valueNamaAkun, valueDebetKredit;

// class AkuntanVDftrAkun {
//   var idAkun, namaAkun;
//   AkuntanVDftrAkun({
//     this.idAkun,
//     this.namaAkun,
//   });

//   // untuk convert dari jSon
//   factory AkuntanVDftrAkun.fromJson(Map<String, dynamic> json) {
//     return new AkuntanVDftrAkun(
//       idAkun: json['id'],
//       namaAkun: json['nama'],
//     );
//   }
// }
Future<String> fetchDataPostDaftarBaru(pUsername, pSandi, pNik, pNamaLkp, pAlmt,
    pTmptLhr, pTglLhr, pStsNkh, pTlp) async {
  final response = await http
      .post(Uri.parse(APIurl + "pasien_v_username_available.php"), body: {
    'username': pUsername.toString(),
    'username': pSandi.toString(),
    'username': pNik.toString(),
    'username': pNamaLkp.toString(),
    'username': pAlmt.toString(),
    'username': pTmptLhr.toString(),
    'username': pTglLhr.toString(),
    'username': pStsNkh.toString(),
    'username': pTlp.toString(),
  });
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataAvailableUsername(username) async {
  final response = await http.post(
      Uri.parse(APIurl + "pasien_v_username_available.php"),
      body: {'username': username.toString()});
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
