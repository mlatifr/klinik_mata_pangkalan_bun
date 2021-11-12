library flutter_application_1.akuntan_fetch_penjualan_nota;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk akun admin
List<AkuntanVPenjualanAdmin> listPenjualanAdmins = [];

class AkuntanVPenjualanAdmin {
  var namaPasien, tglTransaksi, harga;
  AkuntanVPenjualanAdmin({this.namaPasien, this.tglTransaksi, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanAdmin.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanAdmin(
      namaPasien: json['nama_pasien'],
      tglTransaksi: json['tgl_transaksi'],
      harga: json['total_admin'],
    );
  }
}

Future<String> fetchDataVPenjualanAdmin(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_admin.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanJasmed: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun jasmed
List<AkuntanVPenjualanJasmed> listPenjualanJasmeds = [];

class AkuntanVPenjualanJasmed {
  var namaPasien, tglResep, harga;
  AkuntanVPenjualanJasmed({this.namaPasien, this.tglResep, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanJasmed.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanJasmed(
      namaPasien: json['nama_pasien'],
      tglResep: json['periode_transaksi'],
      harga: json['jasa_medis'],
    );
  }
}

Future<String> fetchDataVPenjualanJasmed(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_jasmed.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanJasmed: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun obat
List<AkuntanVPenjualanObat> listPenjualanObats = [];

class AkuntanVPenjualanObat {
  var tglResep, resepId, obatId, nama, jumlah, harga, totalHarga;
  AkuntanVPenjualanObat({
    this.tglResep,
    this.resepId,
    this.obatId,
    this.nama,
    this.jumlah,
    this.harga,
    this.totalHarga,
  });
  // untuk convert dari jSon
  factory AkuntanVPenjualanObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanObat(
        tglResep: json['tgl_resep'],
        resepId: json['resep_id'],
        obatId: json['obat_id'],
        nama: json['nama'],
        jumlah: json['jumlah'],
        harga: json['harga'],
        totalHarga: json['total_harga']);
  }
}

Future<String> fetchDataVPenjualanObat(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_resep_non_visit': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVPenjualanObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
