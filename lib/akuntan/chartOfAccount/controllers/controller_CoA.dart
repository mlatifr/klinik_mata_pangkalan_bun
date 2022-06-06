// library flutter_application_1.controllerCoa;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/services/fetchListCoA.dart';
import 'package:get/get.dart';

class listCoAController extends GetxController {
  var listNamaAkun = <DataCoA>[
    DataCoA(
        nama: 'name',
        editColor: Colors.blue,
        enableEditing: false,
        id: 1,
        no: 1)
  ].obs;
  
  Future AkuntanBacaDataCoa() async {
    listNamaAkun.clear();
    Future dataCoa = fetchAkuntanCoA();
    dataCoa.then((value) {
      print('valuenya:\n$value');
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        DataCoA dataCoA = DataCoA.fromJson(i);
        listNamaAkun.add(dataCoA);
      }
    });
    return listNamaAkun;
  }

  void addAkunCoa(String nama, int no) {
    listNamaAkun.add(DataCoA(
        nama: nama, no: no, enableEditing: false, editColor: Colors.blue));
  }
  
}
