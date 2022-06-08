// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);



class InfoPegawaiModel {
    InfoPegawaiModel({
        this.id,
        this.userKlinikId,
        this.nama,
        this.tlp,
        this.alamat,
        this.username,
        this.sandi,
    });

    int id;
    int userKlinikId;
    String nama;
    String tlp;
    String alamat;
    String username;
    String sandi;

    factory InfoPegawaiModel.fromJson(Map<String, dynamic> json) => InfoPegawaiModel(
        id: json["id"],
        userKlinikId: json["user_klinik_id"],
        nama: json["nama"],
        tlp: json["tlp"],
        alamat: json["alamat"],
        username: json["username"],
        sandi: json["sandi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_klinik_id": userKlinikId,
        "nama": nama,
        "tlp": tlp,
        "alamat": alamat,
        "username": username,
        "sandi": sandi,
    };
}
