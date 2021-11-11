library flutter_application_1.akuntan_fetch_penjualanObat;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk akun admin
List<AkuntanVPenjualanAdmin> ListPenjualanAdmins = [];

class AkuntanVPenjualanAdmin {
  var nama_pasien, tgl_transaksi, harga;
  AkuntanVPenjualanAdmin({this.nama_pasien, this.tgl_transaksi, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanAdmin.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanAdmin(
      nama_pasien: json['nama_pasien'],
      tgl_transaksi: json['tgl_transaksi'],
      harga: json['total_admin'],
    );
  }
}

Future<String> fetchDataVPenjualanAdmin(p_tgl_catat) async {
  final response =
      await http.post(Uri.parse(APIurl + "akuntan_v_pjualan_admin.php"), body: {
    'tgl_transaksi': p_tgl_catat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanJasmed: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun jasmed
List<AkuntanVPenjualanJasmed> ListPenjualanJasmeds = [];

class AkuntanVPenjualanJasmed {
  var nama_pasien, tgl_resep, harga;
  AkuntanVPenjualanJasmed({this.nama_pasien, this.tgl_resep, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanJasmed.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanJasmed(
      nama_pasien: json['nama_pasien'],
      tgl_resep: json['periode_transaksi'],
      harga: json['jasa_medis'],
    );
  }
}

Future<String> fetchDataVPenjualanJasmed(p_tgl_catat) async {
  final response = await http
      .post(Uri.parse(APIurl + "akuntan_v_pjualan_jasmed.php"), body: {
    'tgl_transaksi': p_tgl_catat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanJasmed: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun obat
List<AkuntanVPenjualanObat> ListPenjualanObats = [];

class AkuntanVPenjualanObat {
  var tgl_resep, resep_id, obat_id, nama, jumlah, harga, total_harga;
  AkuntanVPenjualanObat({
    this.tgl_resep,
    this.resep_id,
    this.obat_id,
    this.nama,
    this.jumlah,
    this.harga,
    this.total_harga,
  });
  // untuk convert dari jSon
  factory AkuntanVPenjualanObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanObat(
        tgl_resep: json['tgl_resep'],
        resep_id: json['resep_id'],
        obat_id: json['obat_id'],
        nama: json['nama'],
        jumlah: json['jumlah'],
        harga: json['harga'],
        total_harga: json['total_harga']);
  }
}

Future<String> fetchDataVPenjualanObat(p_tgl_catat) async {
  final response =
      await http.post(Uri.parse(APIurl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_resep_non_visit': p_tgl_catat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
