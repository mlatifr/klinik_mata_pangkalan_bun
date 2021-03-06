library flutter_application_1.fetch_sediaan_barang;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDataVNotaPenjualan(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_nota.php"), body: {
    'tgl_nota': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun obat
List<AkuntanVSediaanBrg> listAkunSediaanBrgs = [];

class AkuntanVSediaanBrg {
  var namaObat, stok, harga;
  AkuntanVSediaanBrg({this.namaObat, this.stok, this.harga});
  // untuk convert dari jSon
  factory AkuntanVSediaanBrg.fromJson(Map<String, dynamic> json) {
    return new AkuntanVSediaanBrg(
      namaObat: json['nama'],
      stok: json['stok'],
      harga: json['harga_beli'],
    );
  }
}

Future<String> fetchDataSediaanBrg() async {
  final response =
      await http.get(Uri.parse(apiUrl + "akuntan_v_sediaan_brg.php"));
  print('fetchDataSediaanBrg ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataSediaanBrgTgl(tgl) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_sediaan_brg.php"), body: {
    'tgl_transaksi': tgl.toString(),
  });
  print('fetchDataSediaanBrgTgl ${response.statusCode}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
