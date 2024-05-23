import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";
// Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';

class ArticleView extends StatefulWidget {

  final String blogurl;
  const ArticleView({super.key,required  this.blogurl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

 late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.blogurl)); // Load the URL passed to the widget
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Row(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("News"),
            Text("App",style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child:Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            )
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body:
      Container(
      child: WebViewWidget(
        controller:controller),
        ),

    ) ;
  }
}