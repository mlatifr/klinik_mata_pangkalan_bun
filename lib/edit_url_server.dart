import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class EditUrlServer extends StatefulWidget {
  const EditUrlServer({Key key}) : super(key: key);

  @override
  _EditUrlServerState createState() => _EditUrlServerState();
}

class _EditUrlServerState extends State<EditUrlServer> {
  TextEditingController _urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _urlController,
                  decoration:
                      new InputDecoration.collapsed(hintText: 'Username'),
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ApiUrl.apiUrl = _urlController.text.toString();
                      });
                    },
                    child: Text('Change Server Url'))),
            Center(
              child: SelectableText(
                "contoh:\nhttp://192.168.1.96:8080/tugas_akhir/\n\nurl sekarang:\n${ApiUrl.apiUrl}",
                style: TextStyle(
                    // color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                textAlign: TextAlign.center,
                onTap: () => print('Tapped'),
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  selectAll: true,
                ),
                showCursor: true,
                cursorWidth: 2,
                cursorColor: Colors.red,
                cursorRadius: Radius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
