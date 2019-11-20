library kopo;

export 'src/kopo_model.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Kopo extends StatefulWidget {
  static const String PATH = '/kopo';

  Kopo({
    Key key,
    this.title = '주소검색',
    this.colour = Colors.white,
    this.apiKey = '',
  }) : super(key: key);

  @override
  _KopoState createState() => _KopoState();

  final String title;
  final Color colour;
  final String apiKey;
}

class _KopoState extends State<Kopo> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colour,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData().copyWith(color: Colors.black),
      ),
      body: WebView(
          initialUrl:
              'https://salondecode.github.io/kopo/assets/daum.html?en=1',
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: Set.from([
            JavascriptChannel(
                name: 'onComplete',
                onMessageReceived: (JavascriptMessage message) {
                  //This is where you receive message from
                  //javascript code and handle in Flutter/Dart
                  //like here, the message is just being printed
                  //in Run/LogCat window of android studio
                  Navigator.pop(context, message.message);
                }),
          ]),
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
//            await _loadHtmlFromAssets(_controller);
          }),
    );
  }
}
