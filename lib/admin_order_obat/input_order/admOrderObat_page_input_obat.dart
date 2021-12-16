import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';

DateTime date;

class AdminOrderInputObat extends StatefulWidget {
  final orderId, obatId, obatNama, orderJumlah;

  const AdminOrderInputObat(
      {Key key, this.orderId, this.obatId, this.obatNama, this.orderJumlah})
      : super(key: key);

  @override
  _AdminOrderInputObatState createState() => _AdminOrderInputObatState();
}

class _AdminOrderInputObatState extends State<AdminOrderInputObat> {
  // // ignore: non_constant_identifier_names
  // PemilikBacaDataVListObat(pNamaObat) {
  //   aVLOs.clear();
  //   Future<String> data = fetchDataPemilikVListObat(pNamaObat);
  //   data.then((value) {
  //     //Mengubah json menjadi Array
  //     // ignore: unused_local_variable
  //     Map json = jsonDecode(value);
  //     print(json);
  //     if (json['result'].toString().contains('success')) {
  //       for (var i in json['data']) {
  //         ApotekerrVListObat avlo = ApotekerrVListObat.fromJson(i);
  //         aVLOs.add(avlo);
  //       }
  //     }
  //     setState(() {
  //       widgetListSuggestObats();
  //     });
  //     print('PemilikBacaDataVListObat aVLOs.length: ${aVLOs.length} ');
  //   });
  // }

  Widget widgetCariObat() {
    return Row(
      children: [
        Expanded(
          flex: 12,
          child: TextFormField(
              controller: controllerCariObat,
              decoration: InputDecoration(
                labelText: "Resep",
                fillColor: Colors.white,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Icon(Icons.search),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 4,
          child: TextButton(
            onPressed: () {
              // PemilikBacaDataVListObat(controllerCariObat.text);
            },
            child: Text(
              'Cari',
            ),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.01)),
          ),
        ),
      ],
    );
  }

  TextEditingController controllerdate = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerHargaBeli = TextEditingController();
  TextEditingController controllerCariObat = TextEditingController();
  int selected; //agar yg terbuka hanya bisa 1 ListTile

  Widget widgetInputObatBaru() {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Input Order',
          textAlign: TextAlign.center,
        ),
      ),
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controllerdate,
                  onChanged: (value) {
                    setState(() {
                      controllerdate.text = value.toString();
                      controllerdate.selection = TextSelection.fromPosition(
                          TextPosition(offset: controllerdate.text.length));
                    });
                  },
                  enabled: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: 'Tanggal Kadaluarsa',
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )),
                ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2200))
                          .then((value) {
                        setState(() {
                          controllerdate.text =
                              value.toString().substring(0, 10);
                        });
                      });
                    },
                    child: Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.white,
                      size: 24.0,
                    ))
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerJumlah,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onTap: () {},
              decoration: InputDecoration(
                labelText: "Jumlah",
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              KeranjangOrderClass krjg = KeranjangOrderClass();
              krjg.id_obat = widget.obatId;
              krjg.id_order = widget.orderId;
              krjg.nama = widget.obatNama;
              krjg.jumlah_diterima = controllerJumlah.text;
              krjg.kadaluarsa = controllerdate.text;
              krjg.status_order = 'diterima';
              listObatKadaluarsa.add(krjg);
              setState(() {
                widgetKeranjangObatBody();
              });
              controllerdate.text = '';
              controllerJumlah.text = '';
            },
            child: Text('tambah'),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.01)),
          ),
        ),
      ],
    );
  }

  Widget widgetKeranjangObatHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Table(
          columnWidths: {
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(2.5),
            2: FlexColumnWidth(2.5),
            3: FlexColumnWidth(2.5),
          },
          border: TableBorder
              .all(), // Allows to add a border decoration around your table
          children: [
            TableRow(children: [
              Text(
                'Obat',
                textAlign: TextAlign.center,
              ),
              Text(
                'Diterima',
                textAlign: TextAlign.center,
              ),
              Text(
                'Exp',
                textAlign: TextAlign.center,
              ),
              Text(
                '',
                textAlign: TextAlign.center,
              ),
            ]),
          ]),
    );
  }

  Widget widgetKeranjangObatBody() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listObatKadaluarsa.length,
          itemBuilder: (context, index) {
            return Table(
                columnWidths: {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(2.5),
                  2: FlexColumnWidth(2.5),
                  3: FlexColumnWidth(2.5),
                },
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${listObatKadaluarsa[index].nama}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${listObatKadaluarsa[index].jumlah_diterima}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${listObatKadaluarsa[index].kadaluarsa}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        listObatKadaluarsa.removeAt(index);
                        setState(() {
                          widgetKeranjangObatBody();
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ]),
                ]);
          }),
    );
  }

  @override
  void initState() {
    DateTime now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              '${widget.obatNama}\n' + 'Jumlah Order: ${widget.orderJumlah}'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  color: Colors.green[50],
                  child: Column(
                    children: [
                      widgetInputObatBaru(),
                      ExpansionTile(
                        title: Text(
                          'Keranjang Obat',
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                        children: [
                          widgetKeranjangObatHeader(),
                          widgetKeranjangObatBody(),
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('SIMPAN'))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
