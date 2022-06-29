import 'package:flutter/material.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/akuntan_page_input_penjurnalan.dart';
import 'package:flutter_application_1/akuntan/page_input_penjurnalan/services/fetchListJurnal.dart';
import 'package:month_year_picker/month_year_picker.dart';

class ListPenjurnalan extends StatefulWidget {
  @override
  State<ListPenjurnalan> createState() => _ListPenjurnalanState();
}

class _ListPenjurnalanState extends State<ListPenjurnalan> {
  DateTime _bulanButton = DateTime.now();
  List _months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('List Penjurnalan'),
        ),
        body: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                  onPressed: () {
                    showMonthYearPicker(
                      context: context,
                      initialDate: _bulanButton,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((value) {
                      setState(() {
                        if (_bulanButton != null) _bulanButton = value;
                        if (_bulanButton == null) _bulanButton = DateTime.now();
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                          '${_months[_bulanButton.month - 1]} ${_bulanButton.year}'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.calendar_today_sharp,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ],
                  ))
            ]),
            SizedBox(
              height: 10,
            ),
            // if(listPenjurnalan!=null)
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                  future: fetchListJurnal(2022),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text('data');
                    } else {
                      return Text('data error');
                    }
                  },
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Scaffold(body: AkuntanInputPenjurnalan());
              },
            );
          },
        ),
      ),
    );
  }
}
