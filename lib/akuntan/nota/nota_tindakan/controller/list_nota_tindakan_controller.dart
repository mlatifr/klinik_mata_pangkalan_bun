import '../model/list_nota_tindakan_model.dart';

class ListNotaTindakanController {
  List<ListNotaTindakanModel> listNotaTindakan = [];
  GetListNotaTindakan(snapshot) {
    listNotaTindakan.clear();
    var _hasilGet = (snapshot.data);
    for (var i in _hasilGet['data']) {
      var jsnRslt = ListNotaTindakanModel.fromJson(i);
      listNotaTindakan.add(jsnRslt);
    }
    print('GetListNotaTindakan: listNotaTindakan.length: ${listNotaTindakan.length}');
  }
}
