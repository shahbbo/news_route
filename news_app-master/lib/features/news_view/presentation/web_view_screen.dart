import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {

  static const routeName = 'web-view';

  const WebViewPage({super.key,});

  @override
  Widget build(BuildContext context) {
    final controller = ModalRoute.of(context)!.settings.arguments as WebViewController;
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}