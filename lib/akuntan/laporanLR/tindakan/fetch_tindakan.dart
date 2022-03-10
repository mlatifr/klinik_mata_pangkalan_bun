library flutter_application_1.fetch_tindakan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk detail nota hpp obat
List<DetailNotaTindakan> listDetailNotaTindakan = [];

class DetailNotaTindakan {
  var nama, mt_sisi, harga_beli;
  DetailNotaTindakan({this.nama, this.mt_sisi, this.harga_beli});
  // untuk convert dari jSon
  factory DetailNotaTindakan.fromJson(Map<String, dynamic> json) {
    return new DetailNotaTindakan(
      nama: json['nama'],
      mt_sisi: json['mt_sisi'],
      harga_beli: json['harga'],
    );
  }
}

Future<String> fetchDataVListDetailNotaTindakan(nota_id) async {
  print('pTglCatat $nota_id');
  final response =
      await http.post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
    'no_nota': nota_id.toString(),
  });
  print('fetchDataVListDetailNotaTindakan: ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk List Nota tindakan per tanggal tertentu
List<ListNotaTindakan> listNotaTindakan = [];

class ListNotaTindakan {
  var no_nota, total_harga;
  ListNotaTindakan({
    this.no_nota,
    this.total_harga,
  });
  // untuk convert dari jSon
  factory ListNotaTindakan.fromJson(Map<String, dynamic> json) {
    return new ListNotaTindakan(
        no_nota: json['nota_id'], total_harga: json['total_harga']);
  }
}

Future<String> fetchDataVListNotaTindakan(pTglCatat) async {
  final response =
      await http.post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
    'tgl_list_nota': pTglCatat.toString(),
  });
  print('fetchDataVListNotaTindakan: ${response.statusCode}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//list tgl tindakan untuk widgetListTindakan()
List<ListTglTindakan> listTglTindakan = [];

class ListTglTindakan {
  var tgl_transaksi, harga;
  ListTglTindakan({
    this.tgl_transaksi,
    this.harga,
  });
  // untuk convert dari jSon
  factory ListTglTindakan.fromJson(Map<String, dynamic> json) {
    return new ListTglTindakan(
        tgl_transaksi: json['tgl_transaksi'], harga: json['harga']);
  }
}

Future<String> fetchDataVListTglTindakan(pTglCatat) async {
  final response =
      await http.post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataVListTglTindakan: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

class AkuntanVTotalTindakan {
  var total_tindakan;
  AkuntanVTotalTindakan({this.total_tindakan});
  // untuk convert dari jSon
  factory AkuntanVTotalTindakan.fromJson(Map<String, dynamic> json) {
    return new AkuntanVTotalTindakan(
      total_tindakan: json['total_tindakan'],
    );
  }
}

Future<String> fetchDataVTotalTindakan(pTglCatat) async {
  print('pTglCatatTindakan $pTglCatat');
  final response =
      await http.post(Uri.parse(ApiUrl.apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
    'tgl_total_tindakan': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    // print('fetchDataVTotalTindakan: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
