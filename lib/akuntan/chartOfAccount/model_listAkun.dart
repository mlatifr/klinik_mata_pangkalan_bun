import 'dart:convert';

import 'package:flutter_application_1/akuntan/chartOfAccount/get_listCoA.dart';

class DataCoA {
  int id;
  int no;
  String nama;
  bool enableEditing;
  DataCoA({this.id, this.no, this.nama, this.enableEditing});

  DataCoA.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    no = json['no'];
    nama = json['nama'];
    enableEditing = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no'] = this.no;
    data['nama'] = this.nama;
    return data;
  }
}
