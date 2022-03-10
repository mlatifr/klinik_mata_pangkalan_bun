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
                        apiUrl = _urlController.text.toString();
                      });
                    },
                    child: Text('Change Server Url'))),
            Text('current url:\n$apiUrl')
          ],
        ),
      ),
    );
  }
}
