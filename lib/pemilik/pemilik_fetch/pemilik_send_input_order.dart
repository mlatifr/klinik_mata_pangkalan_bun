library flutter_application_1.pemilik_send_input_order;

import 'dart:async';
import 'package:flutter/material.dart';
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

List<PemilikInputResepList> ListKeranjangObat = [];
List<TextEditingController> ListHargaJual = [];

class PemilikInputResepList {
  var harga_beli, harga_jual, jumlah_order, obatNama;
  PemilikInputResepList(
      {this.harga_beli, this.harga_jual, this.obatNama, this.jumlah_order});
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

Future<String> fetchDataPemilikVListObat(pNamaObat) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.post(
      Uri.parse(apiUrl + "pemilik_v_list_obat.php"),
      body: {'nama_obat': pNamaObat.toString()});
  if (response.statusCode == 200) {
    // print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
