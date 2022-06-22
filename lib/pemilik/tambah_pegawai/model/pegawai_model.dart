// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class InfoPegawaiModel {
  InfoPegawaiModel(
      {this.id,
      this.userKlinikId,
      this.nama,
      this.tlp,
      this.alamat,
      this.username,
      this.status,
      this.unitKerja});

  int id;
  int userKlinikId;
  String nama;
  String tlp;
  String alamat;
  String username;
  String status;
  String unitKerja;

  factory InfoPegawaiModel.fromJson(Map<String, dynamic> json) =>
      InfoPegawaiModel(
          id: json["id"],
          userKlinikId: json["user_klinik_id"],
          nama: json["nama"],
          tlp: json["tlp"],
          alamat: json["alamat"],
          username: json["username"],
          status: json["status"],
          unitKerja: json["unit_kerja"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_klinik_id": userKlinikId,
        "nama": nama,
        "tlp": tlp,
        "alamat": alamat,
        "username": username,
      };
}
