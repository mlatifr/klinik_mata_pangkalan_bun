library flutter_application_1.kasir_get_resep;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<KasirVKeranjangResep> kVKRs = [];

class KasirVKeranjangResep {
  var resepId,
      userIdApoteker,
      tglResep,
      obatId,
      jumlah,
      dosis,
      namaObat,
      stok,
      hargaJual;
  KasirVKeranjangResep(
      {this.resepId,
      this.userIdApoteker,
      this.tglResep,
      this.obatId,
      this.jumlah,
      this.dosis,
      this.namaObat,
      this.stok,
      this.hargaJual});

  // untuk convert dari jSon
  factory KasirVKeranjangResep.fromJson(Map<String, dynamic> json) {
    return new KasirVKeranjangResep(
      resepId: json['resep_id'],
      userIdApoteker: json['user_id_apoteker'],
      tglResep: json['tgl_resep'],
      obatId: json['obat_id'],
      jumlah: json['jumlah'],
      dosis: json['dosis'],
      namaObat: json['nama'],
      stok: json['stok'],
      hargaJual: json['harga_jual'],
    );
  }
}

Future<String> fetchDataDokterVKeranjangResep(pVisitId) async {
  print('final: $pVisitId');
  final response = await http.post(Uri.parse(apiUrl + "kasir_v_resep.php"),
      body: {"visit_id": pVisitId.toString()});
  if (response.statusCode == 200) {
    print('keranjang kasir_v_resep: ${response.body}');
    return response.body;
  } else {
    print('else kasir_v_resep: ${response.body}');
    throw Exception('Failed to read API');
  }
}
