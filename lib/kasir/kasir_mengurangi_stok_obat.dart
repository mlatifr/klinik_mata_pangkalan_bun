library flutter_application_1.kasir_mengurangi_stok_obat;

import 'dart:async';
import 'package:flutter_application_1/kasir/kasir_get_resep.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List ListStokObatBaru = [];
Function CalculateStokObatBaru() {
  for (var item in kVKRs) {
    int stokLama = item.stok;
    ListStokObatBaru.add(stokLama - int.parse(item.jumlah));
  }
  for (var item in ListStokObatBaru) {
    print(item);
  }
}

// class KasirVKeranjangResep {
//   var resepId,
//       userIdApoteker,
//       tglResep,
//       obatId,
//       jumlah,
//       dosis,
//       namaObat,
//       stok,
//       hargaJual;
//   KasirVKeranjangResep(
//       {this.resepId,
//       this.userIdApoteker,
//       this.tglResep,
//       this.obatId,
//       this.jumlah,
//       this.dosis,
//       this.namaObat,
//       this.stok,
//       this.hargaJual});

//   // untuk convert dari jSon
//   factory KasirVKeranjangResep.fromJson(Map<String, dynamic> json) {
//     return new KasirVKeranjangResep(
//       resepId: json['resep_id'],
//       userIdApoteker: json['user_id_apoteker'],
//       tglResep: json['tgl_resep'],
//       obatId: json['obat_id'],
//       jumlah: json['jumlah'],
//       dosis: json['dosis'],
//       namaObat: json['nama'],
//       stok: json['stok'],
//       hargaJual: json['harga_jual'],
//     );
//   }
// }

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
