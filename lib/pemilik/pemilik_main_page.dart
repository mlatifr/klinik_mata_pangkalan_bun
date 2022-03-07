import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/laporanLR/akuntan_page_laporanLR.dart';
import 'package:flutter_application_1/akuntan/neraca/akuntan_page_neraca.dart';
import 'package:flutter_application_1/pemilik/input_order/pemilik_page_input_order.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../main.dart';
import 'fetch_grafik/fetch_grafik_kas.dart';

class PemilikMainPage extends StatefulWidget {
  const PemilikMainPage({Key key}) : super(key: key);

  @override
  _PemilikMainPageState createState() => _PemilikMainPageState();
}

class _PemilikMainPageState extends State<PemilikMainPage> {
  Widget widgetDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Selamat datang: \n ' + username,
              style: TextStyle(
                backgroundColor: Colors.white.withOpacity(0.85),
                fontSize: 20,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('./asset/image/clinic_text.jpg'),
              ),
            ),
          ),
          ListTile(
            title: Text('Neraca'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AkuntanVNeraca()));
            },
          ),
          ListTile(
            title: Text('Laporan Laba Rugi'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AkuntanVLaporanLR()));
            },
          ),
          ListTile(
            title: Text('Input Order'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PemilikInputOrderObat(pmlkId: userIdMainDart)));
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Navigator.pop(context);
              // _timerForInter.cancel();
              doLogout();
            },
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  PemilikBacaDataGrafikKas(tahun) {
    chartDataKas.clear();
    Future<String> data = fetchDataGrafikKas(tahun);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      print(json);
      if (json['result'].toString().contains('success')) {
        for (var i in json['data']) {
          ChartDataKas avlo = ChartDataKas.fromJson(i);
          chartDataKas.add(avlo);
        }
      }
      setState(() {
        WidgetGrafikKas();
      });
    });
  } // ignore: non_constant_identifier_names

  PemilikBacaDataGrafikVisit(tahun) {
    chartDataVisit.clear();
    Future<String> data = fetchDataGrafikVisit(tahun);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      print(json);
      if (json['result'].toString().contains('success')) {
        for (var i in json['data']) {
          ChartDataVisit avlo = ChartDataVisit.fromJson(i);
          chartDataVisit.add(avlo);
        }
      }
      setState(() {
        WidgetGrafikVisit();
      });
    });
  }

  @override
  void initState() {
    _controllerPeriodeTahun.text = '2022';
    PemilikBacaDataGrafikKas('2022');
    PemilikBacaDataGrafikVisit('2022');
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Halaman Utama"),
          ),
          drawer: widgetDrawer(),
          body: Center(child: WidgetGrafikBI())),
    );
  }

  TextEditingController _controllerPeriodeTahun = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Container WidgetGrafikBI() {
    return Container(
        child: ListView(
      children: [
        widgetButtonYear(),
        WidgetGrafikKas(),
        WidgetGrafikVisit(),
      ],
    ));
  }

  SfCartesianChart WidgetGrafikKas() {
    return SfCartesianChart(
        title: ChartTitle(text: 'Kas'),
        primaryXAxis: CategoryAxis(),
        // Palette colors
        palette: <Color>[
          Colors.teal,
          Colors.orange,
          Colors.brown
        ],
        series: <CartesianSeries>[
          ColumnSeries<ChartDataKas, String>(
              dataSource: chartDataKas,
              xValueMapper: (ChartDataKas data, _) => data.x,
              yValueMapper: (ChartDataKas data, _) => data.y),
          // ColumnSeries<ChartData, String>(
          //     dataSource: chartDataKas,
          //     xValueMapper: (ChartData data, _) => data.x,
          //     yValueMapper: (ChartData data, _) => data.y1),
          // ColumnSeries<ChartData, String>(
          //     dataSource: chartDataKas,
          //     xValueMapper: (ChartData data, _) => data.x,
          //     yValueMapper: (ChartData data, _) => data.y2)
        ]);
  }

  SfCartesianChart WidgetGrafikVisit() {
    return SfCartesianChart(
        title: ChartTitle(text: 'Visit'),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          decimalPlaces: 0,
        ),

        // Palette colors
        palette: <Color>[
          Colors.teal,
          Colors.orange,
          Colors.brown
        ],
        series: <CartesianSeries>[
          ColumnSeries<ChartDataVisit, String>(
            dataSource: chartDataVisit,
            xValueMapper: (ChartDataVisit data, _) => data.x,
            yValueMapper: (ChartDataVisit data, _) => data.y,
          )
        ]);
  }

  Padding widgetButtonYear() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue[300],
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Select Year"),
                  content: Container(
                    // Need to use container to add size constraint.
                    width: 300,
                    height: 300,
                    child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: DateTime(DateTime.now().year + 100, 1),
                      initialDate: DateTime.now(),
                      // save the selected date to _selectedDate DateTime variable.
                      // It's used to set the previous selected date when
                      // re-showing the dialog.
                      selectedDate: _selectedDate,
                      onChanged: (DateTime dateTime) {
                        _selectedDate = dateTime;
                        _controllerPeriodeTahun.text =
                            _selectedDate.toString().substring(0, 4);
                        PemilikBacaDataGrafikKas(_controllerPeriodeTahun.text);
                        PemilikBacaDataGrafikVisit(
                            _controllerPeriodeTahun.text);
                        setState(() {
                          WidgetGrafikKas();
                        });
                        print(
                            '_controllerPeriodeTahun.text ${_controllerPeriodeTahun.text}');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.calendar_today_sharp,
                color: Colors.white,
                size: 32.0,
              ),
              Text(
                '${_controllerPeriodeTahun.text}',
                // style: TextStyle(fontSize: 24),
              ),
            ],
          )),
    );
  }
}
