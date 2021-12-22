library flutter_application_1.akuntan_fetch_penjualan_nota;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

//untuk akun obat
List<AkuntanVNotaPenjualan> listNotaPenjualans = [];

class AkuntanVNotaPenjualan {
  var no_nota, tgl_transaksi, total_harga, nama_kasir;
  AkuntanVNotaPenjualan(
      {this.no_nota, this.tgl_transaksi, this.total_harga, this.nama_kasir});
  // untuk convert dari jSon
  factory AkuntanVNotaPenjualan.fromJson(Map<String, dynamic> json) {
    return new AkuntanVNotaPenjualan(
        no_nota: json['no_nota'],
        tgl_transaksi: json['tgl_transaksi'],
        total_harga: json['total_harga'],
        nama_kasir: json['nama_kasir']);
  }
}

Future<String> fetchDataVNotaPenjualan(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_nota.php"), body: {
    'tgl_nota': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun sediaan barang
List<AkuntanVAkunSediaanBrg> listAkunSediaanBrgs = [];

class AkuntanVAkunSediaanBrg {
  var namaObat, stok, harga;
  AkuntanVAkunSediaanBrg({this.namaObat, this.stok, this.harga});
  // untuk convert dari jSon
  factory AkuntanVAkunSediaanBrg.fromJson(Map<String, dynamic> json) {
    return new AkuntanVAkunSediaanBrg(
      namaObat: json['nama'],
      stok: json['stok'],
      harga: json['harga_beli'],
    );
  }
}

Future<String> fetchDataVAkunSediaanBrg() async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_sediaan_brg.php"), body: {});
  if (response.statusCode == 200) {
    // print('fetchDataVAkunSediaanBrg: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun kas
List<AkuntanVAkunKas> listAkunKass = [];

class AkuntanVAkunKas {
  var namaPasien, tgl_transaksi, harga;
  AkuntanVAkunKas({this.namaPasien, this.tgl_transaksi, this.harga});
  // untuk convert dari jSon
  factory AkuntanVAkunKas.fromJson(Map<String, dynamic> json) {
    return new AkuntanVAkunKas(
      namaPasien: json['nama'],
      tgl_transaksi: json['tgl_transaksi'],
      harga: json['total_harga'],
    );
  }
}

Future<String> fetchDataVAkunKas(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_kas.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    // print('fetchDataVAkunKas: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun tindakan
List<AkuntanVPenjualanTindakan> listPenjualanTindakans = [];

class AkuntanVPenjualanTindakan {
  var namaPasien, tglTransaksi, namaTindakan, harga;
  AkuntanVPenjualanTindakan(
      {this.namaPasien, this.tglTransaksi, this.namaTindakan, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanTindakan.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanTindakan(
      namaPasien: json['nama_pasien'],
      tglTransaksi: json['tglTransaksi'],
      namaTindakan: json['namaTindakan'],
      harga: json['harga'],
    );
  }
}

Future<String> fetchDataVPenjualanTindakan(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_tdkn.php"), body: {
    'tgl_visit_detail': pTglCatat.toString(),
  });
  // print('fetchDataVPenjualanTindakan: $pTglCatat ${response.statusCode}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun HPP Obat
List<AkuntanVHppObat> listHppObats = [];

class AkuntanVHppObat {
  var tgl_transaksi, resepId, obatId, nama, jumlah, harga, totalHarga;
  AkuntanVHppObat({
    this.tgl_transaksi,
    this.resepId,
    this.obatId,
    this.nama,
    this.jumlah,
    this.harga,
    this.totalHarga,
  });
  // untuk convert dari jSon
  factory AkuntanVHppObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVHppObat(
        tgl_transaksi: json['tgl_transaksi'],
        resepId: json['resep_id'],
        obatId: json['obat_id'],
        nama: json['nama'],
        jumlah: json['jumlah'],
        harga: json['harga'],
        totalHarga: json['total_harga']);
  }
}

Future<String> fetchDataVHppObat(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat_hpp.php"), body: {
    'tgl_resep_non_visit': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVHppObat: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun admin
List<AkuntanVPenjualanAdmin> listPenjualanAdmins = [];

class AkuntanVPenjualanAdmin {
  var namaPasien, tglTransaksi, harga;
  AkuntanVPenjualanAdmin({this.namaPasien, this.tglTransaksi, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanAdmin.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanAdmin(
      namaPasien: json['nama_pasien'],
      tglTransaksi: json['tgl_transaksi'],
      harga: json['total_admin'],
    );
  }
}

Future<String> fetchDataVPenjualanAdmin(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_admin.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    ////print('fetchDataVPenjualanJasmed: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun jasmed
List<AkuntanVPenjualanJasmed> listPenjualanJasmeds = [];

class AkuntanVPenjualanJasmed {
  var namaPasien, tglResep, harga;
  AkuntanVPenjualanJasmed({this.namaPasien, this.tglResep, this.harga});
  // untuk convert dari jSon
  factory AkuntanVPenjualanJasmed.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanJasmed(
      namaPasien: json['nama_pasien'],
      tglResep: json['periode_transaksi'],
      harga: json['jasa_medis'],
    );
  }
}

Future<String> fetchDataVPenjualanJasmed(pTglCatat) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_v_pjualan_jasmed.php"), body: {
    'tgl_transaksi': pTglCatat.toString(),
  });
  if (response.statusCode == 200) {
    //print('fetchDataVPenjualanJasmed: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

//untuk akun obat
List<AkuntanVPenjualanObat> listPenjualanObats = [];

class AkuntanVPenjualanObat {
  var tgl_transaksi,
      resepId,
      obatId,
      nama,
      jumlah,
      harga,
      totalHarga,
      idNota,
      user_kasir,
      visit_id;
  AkuntanVPenjualanObat(
      {this.tgl_transaksi,
      this.resepId,
      this.obatId,
      this.nama,
      this.jumlah,
      this.harga,
      this.totalHarga,
      this.idNota,
      this.user_kasir,
      this.visit_id});
  // untuk convert dari jSon
  factory AkuntanVPenjualanObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanObat(
      tgl_transaksi: json['tgl_transaksi'],
      resepId: json['resep_id'],
      obatId: json['obat_id'],
      nama: json['nama'],
      jumlah: json['jumlah'],
      harga: json['harga'],
      totalHarga: json['total_harga'],
      idNota: json['nota_id'],
      user_kasir: json['user_kasir'],
      visit_id: json['visit_id'],
    );
  }
}

Future<String> fetchDataVPenjualanObat(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_penjualan': pTglCatat.toString(),
  });
  print('fetchDataVPenjualanObat ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

// detail nota penjualan obat
List<AkuntanVPenjualanNotaObat> listPenjualanObatNotas = [];

class AkuntanVPenjualanNotaObat {
  var nota_id, user_kasir, visit_id;
  AkuntanVPenjualanNotaObat({this.nota_id, this.user_kasir, this.visit_id});
  // untuk convert dari jSon
  factory AkuntanVPenjualanNotaObat.fromJson(Map<String, dynamic> json) {
    return new AkuntanVPenjualanNotaObat(
      nota_id: json['nota_id'],
      user_kasir: json['user_kasir'],
      visit_id: json['visit_id'],
    );
  }
}

Future<String> fetchDataVPenjualanObatNota(pTglCatat) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_v_pjualan_obat.php"), body: {
    'tgl_resep_nota': pTglCatat.toString(),
  });
  print('fetchDataVPenjualanObatNota ${response.body}');
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
