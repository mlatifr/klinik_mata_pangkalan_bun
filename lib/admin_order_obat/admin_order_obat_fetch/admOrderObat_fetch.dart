library flutter_application_1.admOrderObat_fetch;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk input obat kadaluarsa jika 1 order memiliki banyak tanggal Exp berbeda

Future<String> fetchDataAdminInputKadaluarsaObat(
    order_obat_id, jumlah_order, jumlah_diterima, nama, stok, kadaluarsa, harga_jual, harga_beli, status_order) async {
  print('order_obat_id | $order_obat_id \n' +
      'jumlah_order | $jumlah_order \n' +
      'jumlah_diterima | $jumlah_diterima \n' +
      'nama | $nama \n' +
      'stok | $stok \n' +
      'kadaluarsa | $kadaluarsa \n' +
      'harga_jual | $harga_jual \n' +
      'harga_beli | $harga_beli \n');
  final response = await http.post(Uri.parse(apiUrl + "admin_input_obat_stok.php"), body: {
    'order_obat_id': order_obat_id.toString(),
    'jumlah_order': jumlah_order.toString(),
    'jumlah_diterima': jumlah_diterima.toString(),
    'nama': nama.toString(),
    'stok': stok.toString(),
    'kadaluarsa': kadaluarsa.toString(),
    'harga_jual': harga_jual.toString(),
    'harga_beli': harga_beli.toString(),
    'status_order': status_order.toString(),
  });
  // print('fetchDataAdminInputKadaluarsaObat: ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk update stok order obat yang diterima

List<TextEditingController> ListKadaluarsa = [];
Future<String> fetchDataAdminUpdateOrderObat(jumlah_diterima, stok, kadaluarsa, status_order, obat_id) async {
  final response = await http.post(Uri.parse(apiUrl + "admin_upd_obat_stok.php"), body: {
    'jumlah_diterima': jumlah_diterima.toString(),
    'stok': stok.toString(),
    'kadaluarsa': kadaluarsa.toString(),
    'status_order': status_order.toString(),
    'obat_id': obat_id.toString()
  });
  if (response.statusCode == 200) {
    // print('fetchDataAdminUpdateOrderObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk v list order obat
List<KeranjangOrderClass> listOrderTgl = [];
List<KeranjangOrderClass> listOrderId = [];
List<KeranjangOrderClass> listObatOrder = [];
List<KeranjangOrderClass> listObatKadaluarsa = [];
List<TextEditingController> ListDiterima = [];

class KeranjangOrderClass {
  var tgl_order, id_obat, order_id, jumlah_order, jumlah_diterima, nama, stok, kadaluarsa, harga_jual, harga_beli, status_order;
  KeranjangOrderClass(
      {this.tgl_order,
      this.id_obat,
      this.order_id,
      this.jumlah_order,
      this.jumlah_diterima,
      this.nama,
      this.stok,
      this.kadaluarsa,
      this.harga_jual,
      this.harga_beli,
      this.status_order});
  // untuk convert dari jSon
  factory KeranjangOrderClass.fromJson(Map<String, dynamic> json) {
    return new KeranjangOrderClass(
      tgl_order: json['tgl_order'],
      id_obat: json['id_obat'],
      order_id: json['order_id'],
      jumlah_order: json['jumlah_order'],
      jumlah_diterima: json['jumlah_diterima'],
      nama: json['nama'],
      stok: json['stok'],
      kadaluarsa: json['kadaluarsa'],
      harga_jual: json['harga_jual'],
      harga_beli: json['harga_beli'],
      status_order: json['status_order'],
    );
  }
}

Future<String> fetchDataAdminVOrderTgl() async {
  final response = await http.post(Uri.parse(apiUrl + "admin_v_order_tgl.php"), body: {
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
  final response = await http.post(Uri.parse(apiUrl + "admin_v_order_nota.php"), body: {
    'tgl_order': pTglOrder.toString(),
  });
  print('fetchDataAdminVOrderObatTgl: ${response.body} | ${response.statusCode}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataAdminVListObat(pIdOrder) async {
  print('fetchDataAdminVListObat $pIdOrder');
  final response = await http.post(Uri.parse(apiUrl + "admin_v_order_list_obat.php"), body: {
    'order_id': pIdOrder.toString(),
  });
  print('fetchDataAdminVListObat: ${response.body} | ${response.statusCode}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
