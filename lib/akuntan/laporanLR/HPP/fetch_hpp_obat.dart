library flutter_application_1.fetch_hpp_obat;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk akun HPP Obat
List<AkuntanVHppObat> listHppObats = [];

class AkuntanVHppObat {
  var tgl_transaksi, totalHarga;
  AkuntanVHppObat({
    this.tgl_transaksi,
    this.totalHarga,
  });
  // untuk convert dari jSon
  factory AkuntanVHppObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVHppObat(
        tgl_transaksi: json['tgl_transaksi'], totalHarga: json['total_harga']);
  }
}

Future<String> fetchDataVHppObat(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_hpp_obat': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

class AkuntanVTotalHppObat {
  var hpp_total;
  AkuntanVTotalHppObat({this.hpp_total});
  // untuk convert dari jSon
  factory AkuntanVTotalHppObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVTotalHppObat(
      hpp_total: json['hpp_total'],
    );
  }
}

Future<String> fetchDataVTotalHppObat(pTglCatat) async {
  print('pTglCatat $pTglCatat');
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_total_hpp_obat': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
