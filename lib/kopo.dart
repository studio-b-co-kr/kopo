library kopo;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kopo/src/constans.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum SearchType { daum, juso }

class Kopo extends StatefulWidget {
  static const String PATH = '/kopo';

  Kopo({
    Key key,
    this.title = '주소검색',
    this.colour = Colors.white,
    this.searchType = SearchType.daum,
    this.apiKey = '',
  }) : super(key: key);

  @override
  _KopoState createState() => _KopoState();

  final String title;
  final Color colour;
  final SearchType searchType;
  final String apiKey;
}

class _KopoState extends State<Kopo> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.colour,
        title: Text(widget.title),
        iconTheme: IconThemeData().copyWith(color: Colors.black),
      ),
      body: WebView(
          initialUrl: '',
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
            JavascriptChannel(
                name: 'testComplete',
                onMessageReceived: (JavascriptMessage message) {
                  //This is where you receive message from
                  //javascript code and handle in Flutter/Dart
                  //like here, the message is just being printed
                  //in Run/LogCat window of android studio
                  print('😇 message: ${message.message}');
//                  Navigator.pop(context, message.message);
                })
          ]),
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
            await _loadHtmlFromAssets(_controller);
          }),
    );
  }

  Future<void> _loadHtmlFromAssets(WebViewController controller) async {
    String htmlString = daumHtml;
    if (widget.searchType == SearchType.juso) {
      htmlString = jusoHtml;
      htmlString.replaceAll('{apiKey}', widget.apiKey);
    }
    controller.loadUrl(Uri.dataFromString(htmlString,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
