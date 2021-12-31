library flutter_application_1.fetch_tindakan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

// //untuk detail nota hpp obat
// List<DetailNotaHppPbat> listDetailNotaHppObat = [];

// class DetailNotaHppPbat {
//   var nama, jumlah, harga_beli, total_harga;
//   DetailNotaHppPbat(
//       {this.nama, this.jumlah, this.harga_beli, this.total_harga});
//   // untuk convert dari jSon
//   factory DetailNotaHppPbat.fromJson(Map<String, dynamic> json) {
//     return new DetailNotaHppPbat(
//       nama: json['nama'],
//       jumlah: json['jumlah'],
//       harga_beli: json['harga_beli'],
//       total_harga: json['total_harga'],
//     );
//   }
// }

// Future<String> fetchDataVListDetailNotaHpp(nota_id) async {
//   print('pTglCatat $nota_id');
//   final response = await http
//       .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
//     'nota_id': nota_id.toString(),
//   });
//   if (response.statusCode == 200) {
//     print('fetchDataVListDetailNotaHpp: ${response.body}');
//     return response.body;
//   } else {
//     throw Exception('Failed to read API');
//   }
// }

// //untuk List Nota HPP Obat
// List<AkuntanVListNotaHpp> listNotaHppObats = [];

// class AkuntanVListNotaHpp {
//   var no_nota, total_harga;
//   AkuntanVListNotaHpp({
//     this.no_nota,
//     this.total_harga,
//   });
//   // untuk convert dari jSon
//   factory AkuntanVListNotaHpp.fromJson(Map<String, dynamic> json) {
//     return new AkuntanVListNotaHpp(
//         no_nota: json['no_nota'], total_harga: json['total']);
//   }
// }

// Future<String> fetchDataVListNotaHppObat(pTglCatat) async {
//   final response = await http
//       .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
//     'tgl_list_nota_hpp': pTglCatat.toString(),
//   });
//   if (response.statusCode == 200) {
//     print('fetchDataVListNotaHppObat: ${response.body}');
//     return response.body;
//   } else {
//     throw Exception('Failed to read API');
//   }
// }

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
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
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
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
    'tgl_total_tindakan': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    // print('fetchDataVTotalTindakan: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
