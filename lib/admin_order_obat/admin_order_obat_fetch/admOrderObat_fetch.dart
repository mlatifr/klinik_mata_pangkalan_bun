library flutter_application_1.admOrderObat_fetch;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk update stok order obat yang diterima

List<TextEditingController> ListKadaluarsa = [];
Future<String> fetchDataAdminUpdateOrderObat(
    jumlah_diterima, stok, kadaluarsa, status_order, obat_id) async {
  final response =
      await http.post(Uri.parse(apiUrl + "admin_upd_obat_stok.php"), body: {
    'jumlah_diterima': jumlah_diterima.toString(),
    'stok': stok.toString(),
    'kadaluarsa': kadaluarsa.toString(),
    'status_order': status_order.toString(),
    'obat_id': obat_id.toString()
  });
  if (response.statusCode == 200) {
    print('fetchDataAdminUpdateOrderObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk v list order obat
List<KeranjangOrderClass> listOrderTgl = [];
List<KeranjangOrderClass> listOrderId = [];
List<TextEditingController> ListDiterima = [];

class KeranjangOrderClass {
  var id_order,
      tgl_order,
      id_obat,
      jumlah_order,
      jumlah_diterima,
      nama,
      stok,
      status_order,
      kadaluarsa;
  KeranjangOrderClass(
      {this.id_order,
      this.tgl_order,
      this.id_obat,
      this.jumlah_order,
      this.jumlah_diterima,
      this.nama,
      this.stok,
      this.status_order,
      this.kadaluarsa});
  // untuk convert dari jSon
  factory KeranjangOrderClass.fromJson(Map<String, dynamic> json) {
    return new KeranjangOrderClass(
        tgl_order: json['tgl_order'],
        id_order: json['order_id'],
        id_obat: json['id'],
        jumlah_order: json['jumlah_order'],
        jumlah_diterima: json['jumlah_diterima'],
        nama: json['nama'],
        stok: json['stok'],
        status_order: json['status_order']);
  }
}

Future<String> fetchDataAdminVOrderTgl() async {
  final response =
      await http.post(Uri.parse(apiUrl + "admin_v_order_tgl.php"), body: {
    // 'tgl_order': pTglOrder.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataAdminVOrderObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataAdminVOrderNota(pTglOrder) async {
  print('fetchDataAdminVOrderNota $pTglOrder');
  final response =
      await http.post(Uri.parse(apiUrl + "admin_v_order_nota.php"), body: {
    'tgl_order': pTglOrder.toString(),
  });
  print('fetchDataAdminVOrderObat: ${response.body} | ${response.statusCode}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
