library flutter_application_1.fetch_kas;

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
List<AkuntanVKas> listAkunKass = [];

class AkuntanVKas {
  var tgl_transaksi, totalHarga;
  AkuntanVKas({
    this.tgl_transaksi,
    this.totalHarga,
  });
  // untuk convert dari jSon
  factory AkuntanVKas.fromJson(Map<String, dynamic> json) {
    return new AkuntanVKas(
      tgl_transaksi: json['tgl_transaksi'],
      totalHarga: json['total_harga'],
    );
  }
}

Future<String> fetchDataKas(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_kas.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  // print('fetchDataVPenjualanObat ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
