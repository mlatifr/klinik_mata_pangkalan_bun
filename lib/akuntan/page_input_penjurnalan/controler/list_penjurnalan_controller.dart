import 'package:flutter_application_1/akuntan/page_input_penjurnalan/models/listJurnalModel.dart';

class ListPenjurnalanController {
  List listPenjurnalan = [];
  GetListJurnal(snapshot) {
    listPenjurnalan.clear();
    var hasilGet = (snapshot.data);
    for (var i in hasilGet['data']) {
      var jsnRslt = listJurnalModel.fromJson(i);
      listPenjurnalan.add(jsnRslt);
    }
  }
}
