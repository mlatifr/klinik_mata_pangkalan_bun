library flutter_application_1.admOrderObat_fetch;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

// //untuk akun sediaan barang
// var idOrder = '';

// Future<String> fetchDataIdOrderId(pIdUser, pTglOrder) async {
//   final response = await http
//       .post(Uri.parse(apiUrl + "pemilik_input_tgl_order.php"), body: {
//     'user_klinik_id': pIdUser.toString(),
//     'tgl_order': pTglOrder.toString()
//   });
//   if (response.statusCode == 200) {
//     print('fetchDataIdOrderId: ${response.body}');
//     return response.body;
//   } else {
//     throw Exception('Failed to read API');
//   }
// }

//untuk akun sediaan barang
List<KeranjangOrderClass> listOrderObats = [];
List<TextEditingController> ListDiterima = [];

class KeranjangOrderClass {
  var tgl_order, id_obat, jumlah_order, jumlah_diterima, nama, stok, status_order;
  KeranjangOrderClass(
      {this.tgl_order,
      this.id_obat,
      this.jumlah_order,
      this.jumlah_diterima,
      this.nama,
      this.stok,
      this.status_order});
  // untuk convert dari jSon
  factory KeranjangOrderClass.fromJson(Map<String, dynamic> json) {
    return new KeranjangOrderClass(
        tgl_order: json['tgl_order'],
        id_obat: json['id'],
        jumlah_order: json['jumlah_order'],
        jumlah_diterima: json['jumlah_diterima'],
        nama: json['nama'],
        stok: json['stok'],
        status_order: json['status_order']);
  }
}

Future<String> fetchDataAdminVOrderObat(pTglOrder) async {
  final response =
      await http.post(Uri.parse(apiUrl + "admin_v_pesanan.php"), body: {
    'tgl_order': pTglOrder.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataAdminVOrderObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
