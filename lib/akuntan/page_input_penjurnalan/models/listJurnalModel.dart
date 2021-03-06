// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class listJurnalModel {
  listJurnalModel(
      {this.noAkun,
      this.nama,
      this.tglCatat,
      this.debet,
      this.kredit,
      this.ket_transaksi});

  int noAkun;
  String nama;
  DateTime tglCatat;
  int debet;
  int kredit;
  String ket_transaksi;

  factory listJurnalModel.fromJson(Map<String, dynamic> json) =>
      listJurnalModel(
          noAkun: json["noAkun"],
          nama: json["nama"],
          tglCatat: DateTime.parse(json["tgl_catat"]),
          debet: json["debet"],
          kredit: json["kredit"],
          ket_transaksi: json["ket_transaksi"]);

  Map<String, dynamic> toJson() => {
        "noAkun": noAkun,
        "nama": nama,
        "tgl_catat": tglCatat.toIso8601String(),
        "debet": debet,
        "kredit": kredit,
      };
}
