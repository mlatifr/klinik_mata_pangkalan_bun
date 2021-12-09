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


// //untuk akun sediaan barang
// List<AkuntanVAkunSediaanBrg> listAkunSediaanBrgs = [];

// class AkuntanVAkunSediaanBrg {
//   var namaObat, stok, harga;
//   AkuntanVAkunSediaanBrg({this.namaObat, this.stok, this.harga});
//   // untuk convert dari jSon
//   factory AkuntanVAkunSediaanBrg.fromJson(Map<String, dynamic> json) {
//     return new AkuntanVAkunSediaanBrg(
//       namaObat: json['nama'],
//       stok: json['stok'],
//       harga: json['harga_beli'],
//     );
//   }
// }

// Future<String> fetchDataVAkunSediaanBrg() async {
//   final response = await http
//       .post(Uri.parse(apiUrl + "akuntan_v_sediaan_brg.php"), body: {});
//   if (response.statusCode == 200) {
//     print('fetchDataVAkunSediaanBrg: ${response.body}');
//     return response.body;
//   } else {
//     throw Exception('Failed to read API');
//   }
// }
