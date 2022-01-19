import 'package:flutter/material.dart';
import 'package:flutter_application_1/pemilik/input_order/pemilik_page_input_order.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../main.dart';

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
          // ListTile(
          //   title: Text('Daftar Nota Penjualan'),
          //   onTap: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => AkuntanVNotaPjln()));
          //   },
          // ),
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
          // ListTile(
          //   title: Text('Split View'),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => VerticalSplitView(
          //                   window1: AkuntanVNotaPjln(),
          //                   window2: AkuntanInputPenjurnalan(),
          //                 )));
          //   },
          // ),
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

  TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
      enable: true,
    );
    getUserId();
    super.initState();
  }

  final List<ChartData> chartData = <ChartData>[
    ChartData(x: 'Jan', y1: 45, y2: 1000),
    ChartData(x: 'Feb', y1: 100, y2: 3000),
    ChartData(x: 'March', y1: 25, y2: 1000),
    ChartData(x: 'April', y1: 100, y2: 7000),
    ChartData(x: 'May', y1: 85, y2: 5000),
    ChartData(x: 'June', y1: 140, y2: 7000)
  ];

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
          body: Center(
              child: Container(
                  child: SfCartesianChart(
                      title: ChartTitle(text: 'Half yearly sales analysis'),
                      primaryXAxis: CategoryAxis(),
                      trackballBehavior: _trackballBehavior,
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
              ])))),
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final double y1;
  final double y2;
  ChartData({this.x, this.y, this.y1, this.y2});
}
