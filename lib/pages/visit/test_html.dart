import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medapp/utils/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestHtml extends StatefulWidget {
  final String argument;
  TestHtml({Key key, this.argument}) : super(key: key);

  @override
  _TestHtmlState createState() => _TestHtmlState();
}

class _TestHtmlState extends State<TestHtml> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    final id = widget.argument;
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: HOST_URL + 'phieu_ket_qua/$id/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
