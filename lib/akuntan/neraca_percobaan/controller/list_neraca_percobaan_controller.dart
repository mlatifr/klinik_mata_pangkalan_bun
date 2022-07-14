import '../model/neraca_percobaan_model.dart';

class ListNeracaPercobaanController {
  List<NeracaPercobaanModel> listNeracaPercobaan = [];
  GetListNeracaPercobaan(snapshot) {
    listNeracaPercobaan.clear();
    var _hasilGet = (snapshot.data);
    for (var i in _hasilGet['data']) {
      var jsnRslt = NeracaPercobaanModel.fromJson(i);
      listNeracaPercobaan.add(jsnRslt);
    }
    print('GetListNeracaPercobaan: listNeracaPercobaan.length: ${listNeracaPercobaan.length}');
  }
}
