import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

//
// todo : web view Screen
//
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final controller =
      Completer<WebViewController>(); // Instantiate the controller

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter webview'),
        leading: BackButton(color: Colors.redAccent),
        actions: <Widget>[
          NavigationControls(controller: controller),
          // SampleMenu(_controller.future, widget.cookieManager),
        ],
      ),

      body: WebViewStack(controller: controller),

      // body:    WebView(
      // javascriptMode: JavascriptMode.unrestricted,
      // onWebViewCreated: (WebViewController webViewController) {
      //   _controller.complete(webViewController);
      // },
      // initialUrl: "https://www.coffeechat.jp/",
      // onProgress: (int progress) {
      //   const Center(child: const CircularProgressIndicator());
      //   print('WebView is loading (progress : $progress%)');
      // },
      // onPageStarted: (String url) {
      //   print('Page started loading: $url');
      // },
      // onPageFinished: (String url) {
      //   print('Page finished loading: $url');
      // },
    );
  }
}

//
// todo : web view stack
//

class WebViewStack extends StatefulWidget {
  const WebViewStack({required this.controller, super.key}); // Modify

  final Completer<WebViewController> controller; // Add this attribute

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: 'https://flutter.dev',

          // Add from here ...
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
          // ... to here.
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          gestureNavigationEnabled: true,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
      ],
    );
  }
}

//
// todo : navigation
//

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, super.key});

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return Row(
            children: const <Widget>[
              Icon(Icons.arrow_back_ios),
              Icon(Icons.arrow_forward_ios),
              Icon(Icons.replay),
            ],
          );
        }

        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}

//
// todo : web view screen-2
//

class WebViewScreen2 extends StatefulWidget {
  const WebViewScreen2({Key? key}) : super(key: key);

  @override
  State<WebViewScreen2> createState() => _WebViewScreen2State();
}

class _WebViewScreen2State extends State<WebViewScreen2> {
  final controller =
      Completer<WebViewController>(); // Instantiate the controller

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter webview'),
        actions: <Widget>[
          NavigationControls(controller: controller),
          // SampleMenu(_controller.future, widget.cookieManager),
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          controller.complete(webViewController);
        },
        initialUrl: "https://www.coffeechat.jp/",
        onProgress: (int progress) {
          const Center(child: const CircularProgressIndicator());
          print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
      ),
    );
  }
}
