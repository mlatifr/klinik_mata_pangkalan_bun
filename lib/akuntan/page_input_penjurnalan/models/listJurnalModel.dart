// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class listJurnalModel {
  listJurnalModel({
    this.id,
    this.nama,
    this.tglCatat,
    this.debet,
    this.kredit,
  });

  int id;
  String nama;
  DateTime tglCatat;
  int debet;
  int kredit;

  factory listJurnalModel.fromJson(Map<String, dynamic> json) =>
      listJurnalModel(
        id: json["id"],
        nama: json["nama"],
        tglCatat: DateTime.parse(json["tgl_catat"]),
        debet: json["debet"],
        kredit: json["kredit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "tgl_catat": tglCatat.toIso8601String(),
        "debet": debet,
        "kredit": kredit,
      };
}
