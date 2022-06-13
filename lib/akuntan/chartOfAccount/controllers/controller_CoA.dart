// library flutter_application_1.controllerCoa;

import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:get/get.dart';

class listCoAController extends GetxController {
  List<DataCoA> listNamaAkun = <DataCoA>[DataCoA(nama: 'data null', no: 1)].obs;
  GetCoAList(snapshot) {
    listNamaAkun.clear();
    var hasilGet = (snapshot.data);
    for (var i in hasilGet['data']) {
      var jsnRslt = DataCoA.fromJson(i);
      listNamaAkun.add(jsnRslt);
    }
  }
}
