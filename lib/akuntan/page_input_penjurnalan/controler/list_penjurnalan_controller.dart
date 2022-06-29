import 'package:flutter_application_1/akuntan/page_input_penjurnalan/models/listJurnalModel.dart';

class ListPenjurnalanController {
  List<listJurnalModel> listPenjurnalan = [];
  GetListJurnal(snapshot) {
    listPenjurnalan.clear();
    var hasilGet = (snapshot.data);
    for (var i in hasilGet['data']) {
      var jsnRslt = listJurnalModel.fromJson(i);
      listPenjurnalan.add(jsnRslt);
    }
    print('GetListJurnal: listPenjurnalan.length: ${listPenjurnalan.length}');
  }
}
