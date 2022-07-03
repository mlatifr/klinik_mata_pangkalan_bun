import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> PostEditPegawai(idPegawai, status, nama, unit_kerja, tlp, alamat) async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.post(Uri.parse(apiUrl + "pemilik_edit_pegawai.php"),
      body: {'id_pegawai': '$idPegawai', 'status': '$status', 'nama': '$nama', 'unit_kerja': '$unit_kerja', 'tlp': '$tlp', 'alamat': '$alamat'});
  if (response.statusCode == 200) {
    // print('200: ${jsonDecode(response.body)}');
    // print(hasilGet['data']);
    // for (var item in hasilGet['data']) {
    //   print(item);
    // }
    print('else: ${response.body}');
    return response.body;
  } else {
    print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
