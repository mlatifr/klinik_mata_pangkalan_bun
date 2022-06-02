import 'package:flutter/cupertino.dart';

class DataCoA {
  int id;
  int no;
  String nama;
  bool enableEditing;
  Color editColor;
  DataCoA({this.id, this.no, this.nama, this.enableEditing, this.editColor});

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
