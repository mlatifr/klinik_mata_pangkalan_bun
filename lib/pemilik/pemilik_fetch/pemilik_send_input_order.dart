library flutter_application_1.pemilik_send_input_order;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk akun sediaan barang
var idOrder = '';

Future<String> fetchDataIdOrderId(pIdUser, pTglOrder) async {
  final response = await http
      .post(Uri.parse(apiUrl + "pemilik_input_tgl_order.php"), body: {
    'user_klinik_id': pIdUser.toString(),
    'tgl_order': pTglOrder.toString()
  });
  if (response.statusCode == 200) {
    print('fetchDataIdOrderId: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun sediaan barang
List<KeranjangObatClass> listKeranjangObats = [];

class KeranjangObatClass {
  var order_obat_id, jumlah_order, nama, harga_beli, harga_jual;
  KeranjangObatClass(
      {this.order_obat_id,
      this.jumlah_order,
      this.nama,
      this.harga_beli,
      this.harga_jual});
  // untuk convert dari jSon
  factory KeranjangObatClass.fromJson(Map<String, dynamic> json) {
    return new KeranjangObatClass(
      order_obat_id: json['order_obat_id'],
      jumlah_order: json['jumlah_order'],
      nama: json['nama'],
      harga_beli: json['harga_beli'],
      harga_jual: json['harga_jual'],
    );
  }
}

Future<String> fetchDataPemilikSendKrjgObat(pOrder_obat_id, pJumlah_order,
    pNama, pHarga_beli, pHarga_jual, pStatus_order) async {
  final response = await http
      .post(Uri.parse(apiUrl + "pemilik_input_order_item.php"), body: {
    'order_obat_id': pOrder_obat_id.toString(),
    'jumlah_order': pJumlah_order.toString(),
    'nama': pNama.toString(),
    'harga_beli': pHarga_beli.toString(),
    'harga_jual': pHarga_jual.toString(),
    'status_order': pStatus_order.toString()
  });
  if (response.statusCode == 200) {
    print('fetchDataVAkunSediaanBrg: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
