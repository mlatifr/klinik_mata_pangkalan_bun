class DataCoA {
  int no;
  String nama;
  DataCoA({
    this.no,
    this.nama,
  });

  DataCoA.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['no'] = this.no;
    data['nama'] = this.nama;
    return data;
  }
}
