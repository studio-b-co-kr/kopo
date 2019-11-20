import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopo Demo',
      home: RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String addressJSON = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kopo Demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              child: Text('find Korea Postal address'),
              onPressed: () async {
                String message = await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Kopo(),
                  ),
                );
                KopoModel model = KopoModel.fromJson(jsonDecode(message));
                print(model);
                setState(() {
                  addressJSON = message;
                });
              },
            ),
            Text('$addressJSON'),
          ],
        ),
      ),
    );
  }
}
