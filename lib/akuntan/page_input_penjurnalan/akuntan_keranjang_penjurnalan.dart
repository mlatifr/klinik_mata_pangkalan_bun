library flutter_application_1.akuntan_keranjang_penjurnalan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

List<AkuntanKeranjangPenjurnalan> keranjangTransaksiPenjurnalans = [];

class AkuntanKeranjangPenjurnalan {
  var penjurnalanId,
      daftarAkunId,
      daftarAkunNama,
      tglCatat,
      debet,
      kredit,
      ketTransaksi;
  AkuntanKeranjangPenjurnalan({
    this.penjurnalanId,
    this.daftarAkunId,
    this.daftarAkunNama,
    this.tglCatat,
    this.debet,
    this.kredit,
    this.ketTransaksi,
  });
}

Future<String> fetchDataInputKeranjangPenjurnalan(
  pPenjurnalanId,
  pDaftarAkunId,
  pTglCatat,
  pDebet,
  pKredit,
  pKetTransaksi,
) async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_inpt_penjurnalan_akun.php"), body: {
    'id': pPenjurnalanId.toString(),
    'daftar_akun_id': pDaftarAkunId.toString(),
    'tgl_catat': pTglCatat.toString(),
    'debet': pDebet.toString(),
    'kredit': pKredit.toString(),
    'ket_transaksi': pKetTransaksi.toString(),
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}
