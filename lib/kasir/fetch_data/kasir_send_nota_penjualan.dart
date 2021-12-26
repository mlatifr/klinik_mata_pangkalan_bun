library flutter_application_1.kasir_send_nota_penjualan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class KasirInputNotaJual {
  var visitHasTdknId, nama, harga, mtSisi;
  KasirInputNotaJual({this.visitHasTdknId, this.nama, this.harga, this.mtSisi});

  // untuk convert dari jSon
  factory KasirInputNotaJual.fromJson(Map<String, dynamic> json) {
    return new KasirInputNotaJual(
      visitHasTdknId: json['visit_has_tindakan_id'],
      nama: json['nama'],
      harga: json['harga'],
      mtSisi: json['mt_sisi'],
    );
  }
}

Future<String> fetchDataKasirInputNotaJual(pUserId, pVisitId, pTglTransaksi,
    pJasaMedis, pBiayaAdmin, pTotalHarga, pResepApotekerId) async {
  final response =
      await http.post(Uri.parse(apiUrl + "kasir_input_nota_jual.php"), body: {
    "user_id": pUserId.toString(),
    "visit_id": pVisitId.toString(),
    "tgl_transaksi": pTglTransaksi.toString().substring(0, 10),
    "jasa_medis": pJasaMedis.toString(),
    "biaya_admin": pBiayaAdmin.toString(),
    "total_harga": pTotalHarga.toString(),
    "resep_apoteker_id": pResepApotekerId.toString(),
    
  });
  if (response.statusCode == 200) {
    // print('kasir_input_nota_jual tindakan:  \n'
    //     '$pUserId \n'
    //     '$pVisitId \n'
    //     '$pTglTransaksi \n'
    //     '$pJasaMedis \n'
    //     '$pBiayaAdmin \n'
    //     '$pTotalHarga \n'
    //     '${response.body}');
    return response.body;
  } else {
    // print('kasir_input_nota_jual else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
