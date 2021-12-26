library flutter_application_1.kasir_send_nota_penjualan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class KasirInputNotaJualNonVisit {
  var visitHasTdknId, nama, harga, mtSisi;
  KasirInputNotaJualNonVisit(
      {this.visitHasTdknId, this.nama, this.harga, this.mtSisi});

  // untuk convert dari jSon
  factory KasirInputNotaJualNonVisit.fromJson(Map<String, dynamic> json) {
    return new KasirInputNotaJualNonVisit(
      visitHasTdknId: json['visit_has_tindakan_id'],
      nama: json['nama'],
      harga: json['harga'],
      mtSisi: json['mt_sisi'],
    );
  }
}

Future<String> fetchDataKasirInputNotaJualNonVisit(
    user_id, resep_apoteker_id, tgl_transaksi, total_harga) async {
  final response =
      await http.post(Uri.parse(apiUrl + "kasir_input_nota_jual.php"), body: {
    "user_id": user_id.toString(),
    "resep_apoteker_id": resep_apoteker_id.toString(),
    "tgl_transaksi": tgl_transaksi.toString().substring(0, 10),
    "total_harga": total_harga.toString(),
  });
  if (response.statusCode == 200) {
    print('kasir_input_nota_jual_non_visit:  \n'
        '$user_id \n'
        '$resep_apoteker_id \n'
        '$tgl_transaksi \n'
        '$total_harga \n'
        '${response.body}');
    return response.body;
  } else {
    // print('kasir_input_nota_jual else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
