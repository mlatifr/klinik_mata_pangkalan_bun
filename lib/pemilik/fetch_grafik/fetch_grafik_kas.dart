library flutter_application_1.fetch_grafik_kas;

import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDataIdOrderId(tahun) async {
  final response =
      await http.post(Uri.parse(apiUrl + "pemilik_v_kas.php"), body: {
    'tahun': tahun.toString(),
  });
  if (response.statusCode == 200) {
    print('fetchDataIdOrderId: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

List<ChartData> chartData = <ChartData>[
  ChartData(x: 'Jan', y1: 45, y2: 1000),
  ChartData(x: 'Feb', y1: 100, y2: 3000),
  ChartData(x: 'March', y1: 25, y2: 1000),
  ChartData(x: 'April', y1: 100, y2: 7000),
  ChartData(x: 'May', y1: 85, y2: 5000),
  ChartData(x: 'June', y1: 140, y2: 7000)
];

class ChartData {
  final String x;
  final double y;
  final double y1;
  final double y2;
  ChartData({this.x, this.y, this.y1, this.y2});
  // untuk convert dari jSon
  factory ChartData.fromJson(Map<String, dynamic> json) {
    return new ChartData(
      x: json['bulan'].toString().substring(0, 3),
      y: double.parse(json['kas']),
      y1: double.parse(json['kas']) / 2,
      y2: double.parse(json['kas']) / 3,
      // y1: json['stok'],
      // y2: json['kadaluarsa'],
    );
  }
}
