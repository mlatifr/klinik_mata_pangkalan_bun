library flutter_application_1.apt_get_resep_pasien_detail;

import 'dart:async';
// ignore: unused_import
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<ApotekerrVListObat> aVLOs = [];
List<ApotekerVKeranjangObatDokter> aVKODrs = [];
List<ApotekerVKeranjangObat> aVKOs = [];
List<ApotekerInputResepList> ListInputResep = [];

class ApotekerInputResepList {
  var rspAptkrId, obtId, obatNama, dosis, jumlah, visitId, namaPembeli;
  ApotekerInputResepList(
      {this.rspAptkrId,
      this.obtId,
      this.obatNama,
      this.dosis,
      this.jumlah,
      this.visitId,
      this.namaPembeli});
}

class ApotekerVKeranjangObat {
  var stok, nama, dosis, jumlah;
  ApotekerVKeranjangObat({
    this.nama,
    this.jumlah,
    this.stok,
    this.dosis,
  });

  // untuk convert dari jSon
  factory ApotekerVKeranjangObat.fromJson(Map<String, dynamic> json) {
    return new ApotekerVKeranjangObat(
      nama: json['nama'],
      jumlah: json['jumlah'],
      stok: json['stok'],
      dosis: json['dosis'],
    );
  }
}

class ApotekerVKeranjangObatDokter {
  var resepDokterId, obatId, nama, dosis, jumlah;
  ApotekerVKeranjangObatDokter({
    this.resepDokterId,
    this.obatId,
    this.nama,
    this.dosis,
    this.jumlah,
  });

  // untuk convert dari jSon
  factory ApotekerVKeranjangObatDokter.fromJson(Map<String, dynamic> json) {
    return new ApotekerVKeranjangObatDokter(
      resepDokterId: json['resep_dokter_id'],
      obatId: json['obat_id'],
      nama: json['nama'],
      dosis: json['dosis'],
      jumlah: json['jumlah'],
    );
  }
}

class ApotekerrVListObat {
  var obatId, obatNama, obatStok, kadaluarsa;
  ApotekerrVListObat(
      {this.obatId, this.obatNama, this.obatStok, this.kadaluarsa});

  // untuk convert dari jSon
  factory ApotekerrVListObat.fromJson(Map<String, dynamic> json) {
    return new ApotekerrVListObat(
      obatId: json['id'],
      obatNama: json['nama'],
      obatStok: json['stok'],
      kadaluarsa: json['kadaluarsa'],
    );
  }
}

Future<String> fetchDataApotekerInputRspVst(
    pVisitId, pUserIdApoteker, pTglPenulisanResep) async {
  // print(
  //     'fetchDataApotekerInputRspVst: $pVisit_id | $pUser_id_apoteker | $pTgl_penulisan_resep');
  final response = await http
      .post(Uri.parse(apiUrl + "apoteker_input_resep_visit.php"), body: {
    'visit_id': pVisitId.toString(),
    'user_id_apoteker': pUserIdApoteker.toString(),
    'tgl_penulisan_resep': pTglPenulisanResep.toString()
  });
  if (response.statusCode == 200) {
    // print('fetchDataApotekerInputRspVst: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerInputRsp(
    pUserIdApoteker, pTglPenulisanResep,pNama_pembeli) async {
  // print(
  //     'fetchDataApotekerInputRspVst: $pVisit_id | $pUser_id_apoteker | $pTgl_penulisan_resep');
  final response = await http
      .post(Uri.parse(apiUrl + "apoteker_input_resep_visit.php"), body: {
    'user_id_apoteker': pUserIdApoteker.toString(),
    'tgl_penulisan_resep': pTglPenulisanResep.toString(),
    'nama_pembeli':pNama_pembeli.toString()
  });
  if (response.statusCode == 200) {
    // print('fetchDataApotekerInputRspVst: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerVListObat(pNamaObat) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.post(
      Uri.parse(apiUrl + "apoteker_v_list_obat.php"),
      body: {'nama_obat': pNamaObat.toString()});
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerInputResepObat(
    pRspAptkrId, pObtId, pDosis, pJumlah) async {
  // print('final: $pObtId | $pDosis | $pJumlah | $pVisitId');
  final response = await http
      .post(Uri.parse(apiUrl + "apoteker_input_resep_has_obat.php"), body: {
    "resep_apoteker_id": pRspAptkrId.toString(),
    "obat_id": pObtId.toString(),
    "dosis": pDosis.toString(),
    "jumlah": pJumlah.toString(),
  });
  print('fetchDataApotekerInputResepObat: ${response.body}');
  if (response.statusCode == 200) {
    // print('fetchDataApotekerInputResepObat: ${response.body}');
    return response.body;
  } else {
    // print('else fetchDataApotekerInputResepObat: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerKeranjangObatDokter(pVisitId) async {
  // print('final:$pVisitId');
  final response =
      await http.post(Uri.parse(apiUrl + "apoteker_v_rsp_dr.php"), body: {
    "visit_id": pVisitId.toString(),
  });
  if (response.statusCode == 200) {
    print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataApotekerVKeranjangResepApotekerId(pVisitId) async {
  // print('final:$pVisitId');
  final response = await http.post(
      Uri.parse(apiUrl + "apoteker_v_keranjang_resep_obat_apoteker.php"),
      body: {
        "visit_id": pVisitId.toString(),
      });
  if (response.statusCode == 200) {
    print('apoteker_v_keranjang_resep_obat 200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
