library flutter_application_1.dr_get_list_tindakan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<DokterVListTindakan> dVLTs = [];
List<DokterVKeranjangTindakan> dVKTs = [];

class DokterVKeranjangTindakan {
  var namaTindakan, mataSisiTindakan, tindakanId;
  DokterVKeranjangTindakan({
    this.namaTindakan,
    this.mataSisiTindakan,
    this.tindakanId,
  });

  // untuk convert dari jSon
  factory DokterVKeranjangTindakan.fromJson(Map<String, dynamic> json) {
    return new DokterVKeranjangTindakan(
      namaTindakan: json['nama'],
      mataSisiTindakan: json['mt_sisi'],
      tindakanId: json['tindakan_id'],
    );
  }
}

class DokterVListTindakan {
  var idTindakan, namaTindakan, hargaTindakan;
  DokterVListTindakan({
    this.idTindakan,
    this.namaTindakan,
    this.hargaTindakan,
  });

  // untuk convert dari jSon
  factory DokterVListTindakan.fromJson(Map<String, dynamic> json) {
    return new DokterVListTindakan(
      idTindakan: json['id'],
      namaTindakan: json['nama'],
      hargaTindakan: json['harga'],
    );
  }
}

Future<String> fetchDataDokterVListTindakan() async {
  final response = await http.post(
    Uri.parse(apiUrl + "dokter_v_list_tindakan.php"),
  );
  if (response.statusCode == 200) {
    print('fetchDataDokterVListTindakan: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterVCariListTindakan(pTindakan) async {
  print(pTindakan);
  final response = await http.post(
      Uri.parse(apiUrl + "dokter_v_list_tindakan.php"),
      body: {'tindakan_nama': pTindakan.toString()});
  print(response.body);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterInputTindakan(pVisitId, pTdkId, pMtSisi) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http
      .post(Uri.parse(apiUrl + "dokter_input_tindakan_array.php"), body: {
    "visit_id": pVisitId.toString(),
    "tindakan_id": pTdkId.toString(),
    "mt_sisi": pMtSisi
  });
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterInputTindakanBatal(
    pVisitId, pTdkId, pMtSisi) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http
      .post(Uri.parse(apiUrl + "dokter_input_tindakan_batal.php"), body: {
    "visit_id": pVisitId.toString(),
    "tindakan_id": pTdkId.toString(),
    "mt_sisi": pMtSisi
  });
  if (response.statusCode == 200) {
    print('fetchDataDokterInputTindakanBatal: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataDokterVKeranjangTindakan(pVisitId) async {
  print('final: $pVisitId');
  final response = await http.post(
      Uri.parse(apiUrl + "dokter_v_keranjang_tindakan.php"),
      body: {"visit_id": pVisitId.toString()});
  if (response.statusCode == 200) {
    print('keranjang tindakan: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
