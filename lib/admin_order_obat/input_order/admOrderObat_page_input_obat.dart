import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/admin_order_obat/admin_order_obat_fetch/admOrderObat_fetch.dart';


DateTime date;

class AdminOrderInputObat extends StatefulWidget {
  final orderId, obatId, obatNama, orderJumlah, hargaJual, hargaBeli;

  const AdminOrderInputObat(
      {Key key,
      this.orderId,
      this.obatId,
      this.obatNama,
      this.orderJumlah,
      this.hargaJual,
      this.hargaBeli})
      : super(key: key);

  @override
  _AdminOrderInputObatState createState() => _AdminOrderInputObatState();
}

class _AdminOrderInputObatState extends State<AdminOrderInputObat> {
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
              if (controllerdate.text.isNotEmpty &&
                  controllerJumlah.text.isNotEmpty) {
                KeranjangOrderClass krjg = KeranjangOrderClass();
                krjg.id_obat = widget.obatId;
                krjg.order_id = widget.orderId;
                krjg.nama = widget.obatNama;
                krjg.jumlah_diterima = controllerJumlah.text;
                krjg.kadaluarsa = controllerdate.text;
                krjg.status_order = 'diterima';
                krjg.harga_jual = widget.hargaJual;
                krjg.harga_beli = widget.hargaBeli;
                krjg.jumlah_order = widget.orderJumlah;
                listObatKadaluarsa.add(krjg);
                setState(() {
                  widgetKeranjangObatBody();
                });
                controllerdate.text = '';
                controllerJumlah.text = '';
                print('${krjg.id_obat}\n' +
                    '${krjg.order_id}\n' +
                    '${krjg.nama}\n' +
                    '${krjg.jumlah_diterima}\n' +
                    '${krjg.kadaluarsa}\n' +
                    '${krjg.status_order}\n' +
                    '${krjg.harga_jual}\n' +
                    '${krjg.harga_beli}\n' +
                    '${krjg.jumlah_order}\n');
              } else {
                print('jumlah dan tgl tidak boleh null');
              }
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
                      WidgetButtonSimpan(context)
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

  var enableBtnSimpan = true;
  ElevatedButton WidgetButtonSimpan(BuildContext context) {
    if (enableBtnSimpan == true) {
      return ElevatedButton(
          onPressed: () {
            print(
                'listObatKadaluarsa.length' + ' ${listObatKadaluarsa.length}');
            //untuk index pertama jika ada, update info
            if (listObatKadaluarsa.length > 0) {
              fetchDataAdminUpdateOrderObat(
                      listObatKadaluarsa[0].jumlah_diterima,
                      listObatKadaluarsa[0].jumlah_diterima,
                      listObatKadaluarsa[0].kadaluarsa,
                      'diterima',
                      listObatKadaluarsa[0].id_obat)
                  .then((value) {
                print('fetchDataAdminUpdateOrderObat $value');
                if (value.toString().contains('success')) {
                  if (listObatKadaluarsa.length == 1) {
                    // Navigator.pop(context);
                  }
                  // untuk berikutnya, insert obat jika ada.
                  for (var i = 1; i < listObatKadaluarsa.length; i++) {
                    print('${listObatKadaluarsa[i].nama}|' +
                        '${listObatKadaluarsa[i].jumlah_diterima}|' +
                        '${listObatKadaluarsa[i].kadaluarsa}');
                    fetchDataAdminInputKadaluarsaObat(
                            listObatKadaluarsa[i].order_id,
                            listObatKadaluarsa[i].jumlah_order,
                            listObatKadaluarsa[i].jumlah_diterima,
                            listObatKadaluarsa[i].nama,
                            listObatKadaluarsa[i].jumlah_diterima,
                            listObatKadaluarsa[i].kadaluarsa,
                            listObatKadaluarsa[i].harga_jual,
                            listObatKadaluarsa[i].harga_beli,
                            'diterima')
                        .then((value) {
                      print(
                          'fetchDataAdminInputKadaluarsaObat ${value} print $i');
                      if (i + 1 == listObatKadaluarsa.length) {
                        listObatKadaluarsa.clear();
                        print('last index $i ' +
                            'length ${listObatKadaluarsa.length}');
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AdmOrderObatMainPage()),
                        //     (route) => false);
                      }
                    });
                  }
                } else {
                  print(' value null $value ');
                }
              });
              enableBtnSimpan = false;
              setState(() {
                WidgetButtonSimpan(context);
              });
            } else {
              print('keranjang tidak boleh kosong');
            }
          },
          child: Text('SIMPAN'));
    } else {
      return ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('BACK'));
    }
  }
}
