import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdditionalPage extends StatelessWidget {
  AdditionalPage({super.key});

  final controller = WebViewController()
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
          if (request.url.startsWith(
              'https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7'));

  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {}, child: Text('Rate App')),
        ElevatedButton(
            onPressed: () {
              Share.share(
                'check out my testing application https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7',
              );
            },
            child: Text('Share')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(title: const Text('Testing Task')),
                            body: WebViewWidget(controller: controller),
                          )));
            },
            child: Text('Link'))
      ],
    );
  }
}

// class WebViewWidgetHere extends StatelessWidget {
//   WebViewWidgetHere(this.url);
//   String url;
//   final controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000))
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           if (request.url.startsWith(url)) {
//             return NavigationDecision.prevent;
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse('$url'));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WebView example'),
//       ),
//       body: WebViewWidget(
//         controller: controller,
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
