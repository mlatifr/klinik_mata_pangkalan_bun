import 'dart:convert';

import 'package:flutter/material.dart';
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
  PemilikBacaDataVListObat(tahun) {
    chartData.clear();
    Future<String> data = fetchDataIdOrderId(tahun);
    data.then((value) {
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      print(json);
      if (json['result'].toString().contains('success')) {
        for (var i in json['data']) {
          ChartData avlo = ChartData.fromJson(i);
          chartData.add(avlo);
        }
      }
      setState(() {
        WidgetGrafikBI();
      });
    });
  }

  @override
  void initState() {
    PemilikBacaDataVListObat('2022');
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

  final _controllerPeriodeTahun = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Container WidgetGrafikBI() {
    return Container(
        child: Column(
      children: [
        widgetButtonYear(),
        WidgetGrafik(),
      ],
    ));
  }

  SfCartesianChart WidgetGrafik() {
    return SfCartesianChart(
        title: ChartTitle(text: 'Kas Periode'),
        primaryXAxis: CategoryAxis(),
        // Palette colors
        palette: <Color>[
          Colors.teal,
          Colors.orange,
          Colors.brown
        ],
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y),
          ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y1),
          ColumnSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y2)
        ]);
  }

  Padding widgetButtonYear() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ElevatedButton(
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
                        PemilikBacaDataVListObat(_controllerPeriodeTahun.text);
                        setState(() {
                          WidgetGrafik();
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
          child: Icon(
            Icons.calendar_today_sharp,
            color: Colors.white,
            size: 32.0,
          )),
    );
  }
}
