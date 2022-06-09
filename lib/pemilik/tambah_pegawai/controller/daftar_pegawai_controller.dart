import 'dart:convert';

import 'package:flutter_application_1/pemilik/tambah_pegawai/model/pegawai_model.dart';

class DaftarPegawaiController {
  List<InfoPegawaiModel> listPegawai = [];
  ConvertJsonListPegawai(snapshot) {
    listPegawai.clear();
    var hasilGet = jsonDecode(snapshot.data);
    for (var i in hasilGet['data']) {
      var jsnRslt = InfoPegawaiModel.fromJson(i);
      listPegawai.add(jsnRslt);
    }
  }
}
