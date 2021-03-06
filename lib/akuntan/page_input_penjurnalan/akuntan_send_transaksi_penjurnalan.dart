library flutter_application_1.akuntan_send_transaksi_penjurnalan;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDataAkuntanInputTransaksiPenjurnalan(pIdAkuntan,
    pDaftarAkunId, pTglCatat, pDebet, pKredit, pKetTransaksi) async {
  final response =
      await http.post(Uri.parse(apiUrl + "akuntan_inpt_penjurnalan.php"),
          // body: {'bodyPost': '1'});
          body: {
        'user_klinik_id': pIdAkuntan,
        'daftar_akun_id': pDaftarAkunId,
        'tgl_catat': pTglCatat,
        'debet': pDebet,
        'kredit': pKredit,
        'ket_transaksi': pKetTransaksi,
      });
  // body: jsonEncode({transaksi_array}));
  if (response.statusCode == 200) {
    print('fetchDataAkuntanInputTransaksiPenjurnalan: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> fetchDataAkuntanInputTransaksiPenjurnalanArray() async {
  final response = await http
      .post(Uri.parse(apiUrl + "akuntan_inpt_penjurnalan_akun_copy.php"),
          // body: {'bodyPost': '1'});
          body: {
        'transaksi_array[transaksi_1][id]': '1',
        'transaksi_array[transaksi_1][daftar_akun_id]': '4',
        'transaksi_array[transaksi_1][tgl_catat]': '2021-10-01',
        'transaksi_array[transaksi_1][debet]': '1000000',
        'transaksi_array[transaksi_1][kredit]': '',
        'transaksi_array[transaksi_1][ket_transaksi]': 'pendapatan jasa medis',
        'transaksi_array[transaksi_2][id]': '1',
        'transaksi_array[transaksi_2][daftar_akun_id]': '1',
        'transaksi_array[transaksi_2][tgl_catat]': '2021-10-01',
        'transaksi_array[transaksi_2][debet]': '',
        'transaksi_array[transaksi_2][kredit]': '1000000',
        'transaksi_array[transaksi_2][ket_transaksi]': 'pendapatan jasa medis',
        'transaksi_array[transaksi_3][id]': '1',
        'transaksi_array[transaksi_3][daftar_akun_id]': '4',
        'transaksi_array[transaksi_3][tgl_catat]': '2021-10-01',
        'transaksi_array[transaksi_3][debet]': '',
        'transaksi_array[transaksi_3][kredit]': '40000',
        'transaksi_array[transaksi_3][ket_transaksi]': 'piutang obat',
        'transaksi_array[transaksi_4][id]': '1',
        'transaksi_array[transaksi_4][daftar_akun_id]': '10',
        'transaksi_array[transaksi_4][tgl_catat]': '2021-10-01',
        'transaksi_array[transaksi_4][debet]': '40000',
        'transaksi_array[transaksi_4][kredit]': '',
        'transaksi_array[transaksi_4][ket_transaksi]': 'piutang obat'
      });
  // body: jsonEncode({transaksi_array}));
  if (response.statusCode == 200) {
    print('Array Akuntan Input Penjurnalan: ${response.body}');
    return response.body;
  } else {
    print('ERROR Akuntan Input Penjurnalan: ${response.body}');
    throw Exception('Failed to read API');
  }
}
