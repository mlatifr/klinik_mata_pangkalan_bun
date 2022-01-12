library flutter_application_1.akuntan_fetch_penjualan_obat;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

// Future<String> fetchDataVNotaPenjualan(pTglCatat) async {
//   final response =
//       await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_nota.php"), body: {
//     'tgl_nota': pTglCatat.toString(),
//   });
//   if (response.statusCode == 200) {
//     return response.body;
//   } else {
//     throw Exception('Failed to read API');
//   }
// }

//untuk akun obat
List<AkuntanVPenjualanObat> listPjlnTglObats = [];

class AkuntanVPenjualanObat {
  var tgl_transaksi,
      resepId,
      obatId,
      nama,
      jumlah,
      harga,
      totalHarga,
      idNota,
      user_kasir,
      visit_id;
  AkuntanVPenjualanObat(
      {this.tgl_transaksi,
      this.resepId,
      this.obatId,
      this.nama,
      this.jumlah,
      this.harga,
      this.totalHarga,
      this.idNota,
      this.user_kasir,
      this.visit_id});
  // untuk convert dari jSon
  factory AkuntanVPenjualanObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanObat(
      tgl_transaksi: json['tgl_transaksi'],
      resepId: json['resep_id'],
      obatId: json['obat_id'],
      nama: json['nama'],
      jumlah: json['jumlah'],
      harga: json['harga_jual'],
      totalHarga: json['total_harga'],
      idNota: json['nota_id'],
      user_kasir: json['user_kasir'],
      visit_id: json['visit_id'],
    );
  }
}

Future<String> fetchDataVPjlnTglObat(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_penjualan': pTglCatat.toString(),
  });
  // print('fetchDataVPenjualanObat ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataVPjlnObatTotal(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_penjualan_total': pTglCatat.toString(),
  });
  // print('fetchDataVPenjualanObat ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

class AkuntanVPenjualanNotaObatTotal {
  //kepake
  var text_total_pejualan;
  AkuntanVPenjualanNotaObatTotal({this.text_total_pejualan});
  // untuk convert dari jSon
  factory AkuntanVPenjualanNotaObatTotal.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanNotaObatTotal(
      text_total_pejualan: json['total_penjualan_obat'],
    );
  }
}

// daftar nota penjualan obat
List<AkuntanVPenjualanNotaObat> listNotaPjnlObat = []; //kepake

class AkuntanVPenjualanNotaObat {
  var nota_id, total_harga;
  AkuntanVPenjualanNotaObat({this.nota_id, this.total_harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanNotaObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanNotaObat(
        nota_id: json['nota_id'], total_harga: json['total_penjualan']);
  }
}

//kepake
Future<String> fetchDataVPenjualanListNotaObat(pTglCatat) async {
  // print('pTglCatat $pTglCatat');
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_resep_nota': pTglCatat.toString(),
  });
  // print('fetchDataVPenjualanObatNota ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

// detail nota penjualan obat
List<AkuntanVDetailNotaObat> listDetailNotaPjnlObat = [];

class AkuntanVDetailNotaObat {
  var nama, jumlah_terjual, harga_jual, total_harga;
  AkuntanVDetailNotaObat(
      {this.nama, this.jumlah_terjual, this.harga_jual, this.total_harga});
  // untuk convert dari jSon
  factory AkuntanVDetailNotaObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVDetailNotaObat(
      nama: json['nama'],
      jumlah_terjual: json['jumlah_terjual'],
      harga_jual: json['harga_jual'],
      total_harga: json['total_harga'],
    );
  }
}

Future<String> fetchDataVPjlnDetailNota(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_nota_detail.php"), body: {
    'nota_id': pTglCatat.toString(),
  });
  print('fetchDataVPjlnDetailNota ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
