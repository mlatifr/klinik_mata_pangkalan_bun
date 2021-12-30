library flutter_application_1.fetch_hpp_obat;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk List Nota HPP Obat
List<AkuntanVListNotaHpp> listNotaHppObats = [];

class AkuntanVListNotaHpp {
  var no_nota, total_harga;
  AkuntanVListNotaHpp({
    this.no_nota,
    this.total_harga,
  });
  // untuk convert dari jSon
  factory AkuntanVListNotaHpp.fromJson(Map<String, dynamic> json) {
    return new AkuntanVListNotaHpp(
        no_nota: json['no_nota'], total_harga: json['total']);
  }
}

Future<String> fetchDataVListNotaHppObat(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_list_nota_hpp': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun HPP Obat
List<AkuntanVHppObat> listHppObats = [];

class AkuntanVHppObat {
  var tgl_resep, total_harga;
  AkuntanVHppObat({
    this.tgl_resep,
    this.total_harga,
  });
  // untuk convert dari jSon
  factory AkuntanVHppObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVHppObat(
        tgl_resep: json['tgl_resep'], total_harga: json['total_harga']);
  }
}

Future<String> fetchDataVHppObat(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_list': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    // print('fetchDataVHppObat: ${response.body}');
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
      hpp_total: json['total_harga'],
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
    print('fetchDataVTotalHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
