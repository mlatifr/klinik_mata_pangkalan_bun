// ignore_for_file: missing_return

library flutter_application_1.kasir_mengurangi_stok_obat;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

import 'fetch_data/kasir_get_resep.dart';

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

Function CalculateStokObatBaruNonVisit() {
  ListStokObatBaru.clear();
  for (var item in kasir_krjg_obt_non_visit) {
    stokLama = item.stok_obat - int.parse(item.jumlah);
    ClassStokObatBaru sb =
        ClassStokObatBaru(obatId: item.obat_id, stokObatBaru: stokLama);
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
