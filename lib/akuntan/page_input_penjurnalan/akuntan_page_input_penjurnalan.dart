import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_get_daftar_akun.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_keranjang_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_send_transaksi_penjurnalan.dart';
import 'package:flutter_application_1/main.dart';

class AkuntanInputPenjurnalan extends StatefulWidget {
  const AkuntanInputPenjurnalan({Key key}) : super(key: key);

  @override
  _AkuntanInputPenjurnalanState createState() =>
      _AkuntanInputPenjurnalanState();
}

class _AkuntanInputPenjurnalanState extends State<AkuntanInputPenjurnalan> {
  List<String> selectedItemTindakan;
  Widget widgetDropDownTindakan() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: DropdownButton(
              hint: Text("Pilih Akun"),
              value: valIdAkun,
              items: akntVDftrAkns.map((value) {
                return DropdownMenuItem(
                  value: value.idAkun,
                  child: Text(value.namaAkun),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  valIdAkun = value;
                  valueNamaAkun = akntVDftrAkns[value - 1].namaAkun;
                  print('$valueNamaAkun');
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetDropDownDebetKredit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: DropdownButton(
              hint: Text("Debet/Kredit"),
              value: valueDebetKredit,
              items: debetKredit.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  valueDebetKredit = value;
                  print('$valueDebetKredit');
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetSelectTgl() {
    return Padding(
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
                  print('TextFormField controllerdate $value');
                });
              },
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Tanggal Transaksi',
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
                      controllerdate.text = value.toString().substring(0, 10);
                      print('showDatePicker : $value');
                    });
                  });
                },
                child: Icon(
                  Icons.calendar_today_sharp,
                  color: Colors.white,
                  size: 24.0,
                ))
          ],
        ));
  }

  var controllerdate = TextEditingController();
  int idPenjurnalan = 0;
  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    controllerdate.text = date.toString().substring(0, 10);
    getUserId();
    print('userIdMainDart: ${userIdMainDart.runtimeType}');
    fetchDataAkuntanVDftrAkun().then((value) {
      akntVDftrAkns.clear();
      //Mengubah json menjadi Array
      // ignore: unused_local_variable
      Map json = jsonDecode(value);
      for (var i in json['data']) {
        AkuntanVDftrAkun dvlt = AkuntanVDftrAkun.fromJson(i);
        akntVDftrAkns.add(dvlt);
      }
      setState(() {});
    });
    keranjangTransaksiPenjurnalans.clear();
  }

  TextEditingController controllerNilaiAkun = TextEditingController();
  TextEditingController controllerKeterangan = TextEditingController();
  Widget widgetFormTransaksi() {
    return Column(
      children: [
        widgetSelectTgl(),
        widgetDropDownTindakan(),
        widgetDropDownDebetKredit(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
              enabled: true,
              controller: controllerNilaiAkun,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
          child: TextField(
              enabled: true,
              controller: controllerKeterangan,
              decoration: InputDecoration(
                labelText: "Keterangan",
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
        ElevatedButton(
            onPressed: () {
              AkuntanKeranjangPenjurnalan akntnInptPnjrln =
                  AkuntanKeranjangPenjurnalan();
              akntnInptPnjrln.userIdMainDart = userIdMainDart.toString();
              akntnInptPnjrln.daftarAkunId = valIdAkun.toString();
              akntnInptPnjrln.daftarAkunNama = valueNamaAkun.toString();
              akntnInptPnjrln.tglCatat = controllerdate.text;
              if (valueDebetKredit.toString() == 'debet') {
                akntnInptPnjrln.kredit = '0';
                akntnInptPnjrln.debet = controllerNilaiAkun.text;
              } else if (valueDebetKredit.toString() == 'kredit') {
                akntnInptPnjrln.debet = '0';
                akntnInptPnjrln.kredit = controllerNilaiAkun.text;
              }
              akntnInptPnjrln.ketTransaksi = controllerKeterangan.text;
              keranjangTransaksiPenjurnalans.add(akntnInptPnjrln);
              for (var i in keranjangTransaksiPenjurnalans) {
                print(
                    'penjurnalan_id:${i.userIdMainDart} \ndaftar_akun_id:${i.daftarAkunId}\ntgl_catat:${i.tglCatat}\ndebet:${i.debet}\nkredit:${i.kredit}\nket_transaksi${i.ketTransaksi}');
              }
              setState(() {
                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('$valueNamaAkun berhasil!'),
                  duration: Duration(seconds: 2),
                ));
              });
            },
            child: Text('Tambah')),
      ],
    );
  }

  // ignore: missing_return
  Widget widgetTxtDebetKredit(debet, kredit, i) {
    if (debet > 0) {
      return Text(
        'debet: ${keranjangTransaksiPenjurnalans[i].debet.toString()}',
        style:
            TextStyle(backgroundColor: Colors.blueAccent, color: Colors.white),
      );
    } else if (kredit > 0) {
      return Text(
        'Kredit: ${keranjangTransaksiPenjurnalans[i].kredit.toString()}',
        style: TextStyle(backgroundColor: Colors.red, color: Colors.white),
      );
    }
  }

  // ignore: missing_return
  Widget widgetTextKeranjangTransaksi() {
    if (keranjangTransaksiPenjurnalans.length > 0) {
      return Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: keranjangTransaksiPenjurnalans.length,
              itemBuilder: (context, i) {
                return Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            Text(
                                '${keranjangTransaksiPenjurnalans[i].daftarAkunNama}'),
                            Text(
                                'tgl ${keranjangTransaksiPenjurnalans[i].tglCatat}'),
                            widgetTxtDebetKredit(
                                int.parse(
                                    keranjangTransaksiPenjurnalans[i].debet),
                                int.parse(
                                    keranjangTransaksiPenjurnalans[i].kredit),
                                i),
                            Text(
                                'ket_transaksi: ${keranjangTransaksiPenjurnalans[i].ketTransaksi}'),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          keranjangTransaksiPenjurnalans.removeAt(i);
                          setState(() {
                            widgetTextKeranjangTransaksi();
                          });
                        },
                        child: Icon(Icons.delete))
                  ],
                );
              }),
        ],
      );
    } else if (keranjangTransaksiPenjurnalans.length <= 0) {
      return Center(child: Text('Keranjang masih kosong'));
    }
  }

  // ignore: missing_return
  Function functionSimpanPenjurnalan() {
    if (keranjangTransaksiPenjurnalans.isNotEmpty) {
      for (var i in keranjangTransaksiPenjurnalans) {
        print('${i.tglCatat}');
      }
      for (var i = 0; i < keranjangTransaksiPenjurnalans.length; i++) {
        fetchDataAkuntanInputTransaksiPenjurnalan(
                keranjangTransaksiPenjurnalans[i].userIdMainDart,
                keranjangTransaksiPenjurnalans[i].daftarAkunId,
                keranjangTransaksiPenjurnalans[i].tglCatat,
                keranjangTransaksiPenjurnalans[i].debet,
                keranjangTransaksiPenjurnalans[i].kredit,
                keranjangTransaksiPenjurnalans[i].ketTransaksi)
            .then((value) {
          Map json = jsonDecode(value);
          if (json['result'].toString() == 'success') {
            // ignore: deprecated_member_use
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(value),
              duration: Duration(milliseconds: 100),
            ));
            keranjangTransaksiPenjurnalans.clear();
            setState(() {
              widgetTextKeranjangTransaksi();
              Navigator.pop(context);
            });
          } else if (json['result'].toString() == 'fail') {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  '$value',
                  style: TextStyle(fontSize: 14),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('ok')),
                ],
              ),
            );
          }
        });
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget widgetListViewBodyPage() {
    return ListView(
      children: [
        ExpansionTile(
            title: Text(
              'Input Transaksi',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            children: [widgetFormTransaksi()]),
        ExpansionTile(
            title: Text(
              'Keranjang Transaksi',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            children: [widgetTextKeranjangTransaksi()]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      'WARNING!\nData yg sudah di simpan tidak bisa di edit lagi',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            functionSimpanPenjurnalan();
                            Navigator.pop(context);
                          },
                          child: Text('ok')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                    ],
                  ),
                );
              },
              child: Text('simpan')),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Input Penjurnalan"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: widgetListViewBodyPage()),
    );
  }
}
