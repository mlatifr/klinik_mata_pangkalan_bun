class ListNotaObatModel {
  ListNotaObatModel({
    this.tanggal,
    this.nama,
    this.stok,
    this.terjual,
    this.hargaJual,
    this.hargaBeli,
    this.statusOrder,
  });

  DateTime tanggal;
  String nama;
  int stok;
  int terjual;
  String hargaJual;
  String hargaBeli;
  String statusOrder;
  factory ListNotaObatModel.fromJson(Map<String, dynamic> json) => ListNotaObatModel(
        tanggal: DateTime.parse(json["tanggal"]),
        nama: json["nama"],
        stok: json["stok"],
        terjual: json["terjual"],
        hargaJual: json["harga_jual"],
        hargaBeli: json["harga_beli"],
        statusOrder: json["status_order"],
      );
}
