import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> FetchInfoPegawai() async {
  // print('final: $pVisitId | $pTdkId | $pMtSisi');
  final response = await http.get(
    Uri.parse(apiUrl + "pemilik_v_pegawai.php"),
  );
  if (response.statusCode == 200) {
    print('200: ${response.body}');
    return response.body;
  } else {
    // print('else: ${response.body}');
    throw Exception('Failed to read API');
  }
}
