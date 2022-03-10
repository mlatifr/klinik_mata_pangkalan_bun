library flutter_application_1.kasir_get_resep;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<KasirVKeranjangResep> kVKRs = [];

class KasirVKeranjangResep {
  var resepId,
      userIdApoteker,
      tglResep,
      obatId,
      jumlah,
      dosis,
      namaObat,
      stok,
      hargaJual;
  KasirVKeranjangResep(
      {this.resepId,
      this.userIdApoteker,
      this.tglResep,
      this.obatId,
      this.jumlah,
      this.dosis,
      this.namaObat,
      this.stok,
      this.hargaJual});

  // untuk convert dari jSon
  factory KasirVKeranjangResep.fromJson(Map<String, dynamic> json) {
    return new KasirVKeranjangResep(
      resepId: json['resep_id'],
      userIdApoteker: json['user_id_apoteker'],
      tglResep: json['tgl_resep'],
      obatId: json['obat_id'],
      jumlah: json['jumlah'],
      dosis: json['dosis'],
      namaObat: json['nama'],
      stok: json['stok'],
      hargaJual: json['harga_jual'],
    );
  }
}

Future<String> fetchDataKasirVKeranjangResep(pVisitId) async {
  //print('final: $pVisitId');
  final response = await http.post(Uri.parse(ApiUrl.apiUrl + "kasir_v_resep.php"),
      body: {"visit_id": pVisitId.toString()});
  if (response.statusCode == 200) {
    //print('keranjang kasir_v_resep: ${response.body}');
    return response.body;
  } else {
    //print('else kasir_v_resep: ${response.body}');
    throw Exception('Failed to read API');
  }
}

// kasir lihat tgl resep apoteker untuk pembeli yg tidak visit dokter

List<KasirVKrjgTglNonVisit> kasir_list_tgl_rsp_non_visit = [];

class KasirVKrjgTglNonVisit {
  var resep_apoteker_id, tgl_penulisan_resep, nama_pembeli;
  KasirVKrjgTglNonVisit({
    this.resep_apoteker_id,
    this.tgl_penulisan_resep,
    this.nama_pembeli,
  });

  // untuk convert dari jSon
  factory KasirVKrjgTglNonVisit.fromJson(Map<String, dynamic> json) {
    return new KasirVKrjgTglNonVisit(
      resep_apoteker_id: json['resep_apoteker_id'],
      tgl_penulisan_resep: json['tgl_penulisan_resep'],
      nama_pembeli: json['nama_pembeli'],
    );
  }
}

Future<String> fetchDataKasirVTglNonVisit(tgl_penulisan_resep) async {
  // print('fetchDataKasirVKeranjangResepNonVisit: $tgl_penulisan_resep');
  final response = await http.post(Uri.parse(ApiUrl.apiUrl + "kasir_v_antrean.php"),
      body: {"tgl_penulisan_resep": tgl_penulisan_resep.toString()});
  // print('tgl_penulisan_resep: ${response.statusCode}');
  if (response.statusCode == 200) {
    print('tgl_penulisan_resep: ${response.body}');
    return response.body;
  } else {
    // print('else tgl_penulisan_resep: ${response.body}');
    throw Exception('Failed to read API');
  }
}

// kasir lihat detail obat yg dibeli (resep) apoteker untuk pembeli yg tidak visit dokter

List<KasirVKrjgObatNonVisit> kasir_krjg_obt_non_visit = [];

class KasirVKrjgObatNonVisit {
  var resep_apoteker_id,
      tgl_penulisan_resep,
      nama_pembeli,
      jumlah,
      harga_jual,
      nama_obat,
      stok_obat,
      obat_id;
  KasirVKrjgObatNonVisit(
      {this.resep_apoteker_id,
      this.tgl_penulisan_resep,
      this.nama_pembeli,
      this.jumlah,
      this.harga_jual,
      this.nama_obat,
      this.stok_obat,
      this.obat_id});

  // untuk convert dari jSon
  factory KasirVKrjgObatNonVisit.fromJson(Map<String, dynamic> json) {
    return new KasirVKrjgObatNonVisit(
      resep_apoteker_id: json['resep_id'],
      tgl_penulisan_resep: json['tgl_penulisan_resep'],
      nama_pembeli: json['nama_pembeli'],
      jumlah: json['jumlah'],
      harga_jual: json['harga_jual'],
      nama_obat: json['nama'],
      stok_obat: json['stok'],
      obat_id: json['obat_id'],
    );
  }
}

Future<String> fetchDataKasirVKeranjangResepNonVisit(resep_apoteker_id) async {
  // print('fetchDataKasirVKeranjangResepNonVisit: $resep_apoteker_id');
  final response = await http.post(Uri.parse(ApiUrl.apiUrl + "kasir_v_antrean.php"),
      body: {"resep_id_non_visit": resep_apoteker_id.toString()});
  // print('fetchDataKasirVKeranjangResepNonVisit: ${response.statusCode}');
  if (response.statusCode == 200) {
    print('fetchDataKasirVKeranjangResepNonVisit: ${response.body}');
    return response.body;
  } else {
    // print('else tgl_penulisan_resep: ${response.body}');
    throw Exception('Failed to read API');
  }
}
