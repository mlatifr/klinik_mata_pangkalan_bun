import 'package:flutter_application_1/akuntan/nota/nota_obat/model/list_nota_obat_model.dart';

class ListNotaObatController {
  List<ListNotaObatModel> listNotaObat = [];
  GetListNotaObat(snapshot) {
    listNotaObat.clear();
    var _hasilGet = (snapshot.data);
    for (var i in _hasilGet['data']) {
      var jsnRslt = ListNotaObatModel.fromJson(i);
      listNotaObat.add(jsnRslt);
    }
    print('GetListNotaObat: listNotaObat.length: ${listNotaObat.length}');
  }
}
