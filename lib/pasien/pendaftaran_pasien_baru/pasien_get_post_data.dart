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

Future<String> fetchDataPostDaftarUsernameBaru(pUsername, pSandi) async {
  final response = await http
      .post(Uri.parse(ApiUrl.apiUrl + "pasien_v_username_available.php"), body: {
    'username': pUsername.toString(),
    'sandi': pSandi.toString(),
  });
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataPostDaftarBaru(
    pUsername,
    pSandi,
    pNik,
    pNamaLkp,
    pAlmt,
    pAgama,
    pTmptLhr,
    pTglLhr,
    pJnsKlm,
    pGolDar,
    pStatusNikah,
    pPekerjaan,
    pKewarganegaraan,
    pTlp) async {
  final response =
      await http.post(Uri.parse(ApiUrl.apiUrl + "pasien_daftar_user_baru.php"), body: {
    'username': pUsername.toString(),
    'sandi': pSandi.toString(),
    'NIK': pNik.toString(),
    'nama': pNamaLkp.toString(),
    'tempat_lahir': pTmptLhr.toString(),
    'tgl_lahir': pTglLhr.toString(),
    'kelamin': pJnsKlm.toString(),
    'golongan_darah': pGolDar.toString(),
    'alamat': pAlmt.toString(),
    'agama': pAgama.toString(),
    'status_kawin': pStatusNikah.toString(),
    'pekerjaan': pPekerjaan.toString(),
    'kewarganegaraan': pKewarganegaraan.toString(),
    'tlp': pTlp.toString(),
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
      Uri.parse(ApiUrl.apiUrl + "pasien_v_username_available.php"),
      body: {'username': username.toString()});
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
