library flutter_application_1.pemilik_model;

import 'package:flutter/widgets.dart';
List<PemilikInputResepList> ListKeranjangObat = [];
List<TextEditingController> ListHargaJual = [];

class PemilikInputResepList {
  var harga_beli, harga_jual, jumlah_order, obatNama;
  PemilikInputResepList(
      {this.harga_beli, this.harga_jual, this.obatNama, this.jumlah_order});
}
