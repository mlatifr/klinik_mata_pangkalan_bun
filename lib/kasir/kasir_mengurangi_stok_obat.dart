library flutter_application_1.kasir_mengurangi_stok_obat;

import 'dart:async';
import 'package:flutter_application_1/kasir/kasir_get_resep.dart';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

class ClassStokObatBaru {
  var obatId, stokObatBaru;
  ClassStokObatBaru({this.obatId, this.stokObatBaru});
}

int stokLama;
List ListStokObatBaru = [];
Function CalculateStokObatBaru() {
  ListStokObatBaru.clear();
  for (var item in kVKRs) {
    stokLama = item.stok - int.parse(item.jumlah);
    ClassStokObatBaru sb =
        ClassStokObatBaru(obatId: item.obatId, stokObatBaru: stokLama);
    ListStokObatBaru.add(sb);
  }
  // for (var item in ListStokObatBaru) {
  //   print(item.obatId.toString() + '|' + item.stokObatBaru.toString());
  //   updateStokObat(item.obatId, item.stokObatBaru);
  // }
  for (var i = 0; i < ListStokObatBaru.length; i++) {
    // print(
    //     '${ListStokObatBaru[i].obatId} | ${ListStokObatBaru[i].stokObatBaru}');
    updateStokObat(
        ListStokObatBaru[i].obatId, ListStokObatBaru[i].stokObatBaru);
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

Future<String> updateStokObat(pObatId, pObatStok) async {
  print('$pObatId | $pObatStok');
  final response = await http
      .post(Uri.parse(apiUrl + "kasir_update_stok_obat.php"), body: {
    "obat_id": pObatId.toString(),
    "stok_obat_baru": pObatStok.toString()
  });
  if (response.statusCode == 200) {
    print('updateStokObat : ${response.body}');
    return response.body;
  } else {
    print('else updateStokObat: ${response.statusCode}');
    throw Exception('Failed to read API');
  }
}
