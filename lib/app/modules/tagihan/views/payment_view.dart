import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  final String url;

  const PaymentView({Key? key, required this.url}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optionally handle progress updates
          },
          onPageStarted: (String url) {
            // Optionally handle when page starts loading
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            // Optionally handle when page finishes loading
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            // Optionally handle errors
            print('Web resource error: $error');
          },
        ),
      );

    // Load the provided URL
    if (widget.url.isNotEmpty) {
      _controller.loadRequest(Uri.parse(widget.url));
    } else {
      print('Error: URL is empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment View'),
        centerTitle: true,
      ),
      body: widget.url.isNotEmpty
          ? WebViewWidget(controller: _controller)
          : Center(child: Text('Invalid URL')),
    );
  }
}



// 'https://app.sandbox.midtrans.com/snap/'