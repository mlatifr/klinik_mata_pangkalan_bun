// library flutter_application_1.controllerCoa;
import 'package:flutter_application_1/akuntan/chartOfAccount/models/model_listAkun.dart';
import 'package:get/get.dart';

class listCoAController extends GetxController {
  var listNamaAkun = <DataCoA>[DataCoA(nama: 'name', no: 1)].obs;
  GetCoAList(snapshot) {
    listNamaAkun.clear();
    var hasilGet = snapshot.data['data'];
    for (var i in hasilGet) {
      var jsnRslt = DataCoA.fromJson(i);
      listNamaAkun.add(jsnRslt);
    }
  }
}
