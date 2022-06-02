// library flutter_application_1.controllerCoa;

import 'dart:convert';
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:flutter_application_1/akuntan/chartOfAccount/services/fetchListCoA.dart';
import 'package:get/get.dart';

class listCoAController extends GetxController {
  var listNamaAkun = <DataCoA>[].obs;
  Future AkuntanBacaDataCoa() async {
    listNamaAkun.clear();
    Future dataCoa = fetchAkuntanCoA();
    dataCoa.then((value) {
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        DataCoA dataCoA = DataCoA.fromJson(i);
        listNamaAkun.add(dataCoA);
      }
    });
    return listNamaAkun;
  }
}
