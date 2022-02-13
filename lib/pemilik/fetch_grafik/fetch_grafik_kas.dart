library flutter_application_1.fetch_grafik_kas;

import 'dart:async';
import 'package:flutter_application_1/main.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDataGrafikKas(tahun) async {
  final response =
      await http.post(Uri.parse(apiUrl + "pemilik_v_kas.php"), body: {
    'tahun': tahun.toString(),
  });
  if (response.statusCode == 200) {
    // print('fetchDataIdOrderId: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

List<ChartDataKas> chartDataKas = <ChartDataKas>[
  // ChartDataKas(x: 'Jan', y1: 45, y2: 1000),
  // ChartDataKas(x: 'Feb', y1: 100, y2: 3000),
  // ChartDataKas(x: 'March', y1: 25, y2: 1000),
  // ChartDataKas(x: 'April', y1: 100, y2: 7000),
  // ChartDataKas(x: 'May', y1: 85, y2: 5000),
  // ChartDataKas(x: 'June', y1: 140, y2: 7000)
];

class ChartDataKas {
  final String x;
  final double y;
  final double y1;
  final double y2;
  ChartDataKas({this.x, this.y, this.y1, this.y2});
  // untuk convert dari jSon
  factory ChartDataKas.fromJson(Map<String, dynamic> json) {
    return new ChartDataKas(
      x: json['bulan'].toString().substring(0, 3),
      y: double.parse(json['kas']),
      y1: double.parse(json['kas']) / 2,
      y2: double.parse(json['kas']) / 3,
      // y1: json['stok'],
      // y2: json['kadaluarsa'],
    );
  }
}

Future<String> fetchDataGrafikVisit(tahun) async {
  final response =
      await http.post(Uri.parse(apiUrl + "pemilik_v_visit.php"), body: {
    'tahun': tahun.toString(),
  });
  if (response.statusCode == 200) {
    // print('fetchDataGrafikVisit: ${response.body}');
    return response.body;
  } else {
    throw Exception('Failed to read API');
  }
}

List<ChartDataVisit> chartDataVisit = <ChartDataVisit>[
  // ChartDataVisit(x: 'Jan', y1: 45, y2: 1000),
  // ChartDataVisit(x: 'Feb', y1: 100, y2: 3000),
  // ChartDataVisit(x: 'March', y1: 25, y2: 1000),
  // ChartDataVisit(x: 'April', y1: 100, y2: 7000),
  // ChartDataVisit(x: 'May', y1: 85, y2: 5000),
  // ChartDataVisit(x: 'June', y1: 140, y2: 7000)
];

class ChartDataVisit {
  final String x;
  final num y;
  final int y1;
  final int y2;
  ChartDataVisit({this.x, this.y, this.y1, this.y2});
  // untuk convert dari jSon
  factory ChartDataVisit.fromJson(Map<String, dynamic> json) {
    return new ChartDataVisit(
      x: json['bulan'].toString().substring(0, 3),
      y: json['visit'],
      // y1: json['visit'] / 2,
      // y2: json['visit'] / 3,
      // y1: json['stok'],
      // y2: json['kadaluarsa'],
    );
  }
}
