library flutter_application_1.fetch_hpp_obat;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk detail nota hpp obat
List<DetailNotaHppPbat> listDetailNotaHppObat = [];

class DetailNotaHppPbat {
  var nama, jumlah, harga_beli, total_harga;
  DetailNotaHppPbat(
      {this.nama, this.jumlah, this.harga_beli, this.total_harga});
  // untuk convert dari jSon
  factory DetailNotaHppPbat.fromJson(Map<String, dynamic> json) {
    return new DetailNotaHppPbat(
      nama: json['nama'],
      jumlah: json['jumlah'],
      harga_beli: json['harga_beli'],
      total_harga: json['total_harga'],
    );
  }
}

Future<String> fetchDataVListDetailNotaHpp(nota_id) async {
  //print('pTglCatat $nota_id');
  final response = await http
      .post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'nota_id': nota_id.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVListDetailNotaHpp: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk List Nota HPP Obat
List<AkuntanVListNotaHpp> listNotaHppObats = [];

class AkuntanVListNotaHpp {
  var nota_id, total_penjualan;
  AkuntanVListNotaHpp({
    this.nota_id,
    this.total_penjualan,
  });
  // untuk convert dari jSon
  factory AkuntanVListNotaHpp.fromJson(Map<String, dynamic> json) {
    return new AkuntanVListNotaHpp(
        nota_id: json['nota_id'], total_penjualan: json['total_penjualan']);
  }
}

Future<String> fetchDataVListNotaHppObat(pTglCatat) async {
  final response = await http
      .post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_list_nota_hpp': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVListNotaHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun HPP Obat
List<AkuntanVHppObat> listHppObats = [];

class AkuntanVHppObat {
  var tgl_transaksi, total_harga, total_nota;
  AkuntanVHppObat({this.tgl_transaksi, this.total_harga, this.total_nota});
  // untuk convert dari jSon
  factory AkuntanVHppObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVHppObat(
        total_nota: json['total_nota'],
        tgl_transaksi: json['tgl_transaksi'],
        total_harga: json['total_harga']);
  }
}

Future<String> fetchDataVHppObat(pTglCatat) async {
  final response = await http
      .post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_list': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    // //print('fetchDataVHppObat: ${response.body}');
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
  //print('pTglCatat $pTglCatat');
  final response = await http
      .post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_total_hpp_obat': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVTotalHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
