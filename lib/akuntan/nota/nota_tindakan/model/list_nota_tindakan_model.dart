// To parse this JSON data, do
//
//     final listNotaObatModel = listNotaObatModelFromJson(jsonString);

class ListNotaTindakanModel {
  ListNotaTindakanModel({
    this.tglVisit,
    this.username,
    this.visitHasTindakanId,
    this.nama,
    this.harga,
    this.mtSisi,
  });

  DateTime tglVisit;
  String username;
  int visitHasTindakanId;
  String nama;
  int harga;
  String mtSisi;

  factory ListNotaTindakanModel.fromJson(Map<String, dynamic> json) => ListNotaTindakanModel(
        tglVisit: DateTime.parse(json["tgl_visit"]),
        username: json["username"],
        visitHasTindakanId: json["visit_has_tindakan_id"],
        nama: json["nama"],
        harga: json["harga"],
        mtSisi: json["mt_sisi"],
      );

  Map<String, dynamic> toJson() => {
        "tgl_visit": tglVisit.toIso8601String(),
        "username": username,
        "visit_has_tindakan_id": visitHasTindakanId,
        "nama": nama,
        "harga": harga,
        "mt_sisi": mtSisi,
      };
}
