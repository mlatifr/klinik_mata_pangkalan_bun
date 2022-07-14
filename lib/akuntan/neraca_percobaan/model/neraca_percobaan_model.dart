// To parse this JSON data, do
//
//     final neracaPercobaanModel = neracaPercobaanModelFromJson(jsonString);

class NeracaPercobaanModel {
  NeracaPercobaanModel({
    this.tglCatat,
    this.no,
    this.nama,
    this.debet,
    this.kredit,
  });

  DateTime tglCatat;
  int no;
  String nama;
  String debet;
  String kredit;

  factory NeracaPercobaanModel.fromJson(Map<String, dynamic> json) => NeracaPercobaanModel(
        tglCatat: DateTime.parse(json["tgl_catat"]),
        no: json["no"],
        nama: json["nama"],
        debet: json["debet"],
        kredit: json["kredit"],
      );

  Map<String, dynamic> toJson() => {
        "tgl_catat": tglCatat.toIso8601String(),
        "no": no,
        "nama": nama,
        "debet": debet,
        "kredit": kredit,
      };
}
