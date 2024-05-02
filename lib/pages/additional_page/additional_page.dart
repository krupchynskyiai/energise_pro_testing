import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdditionalPage extends StatefulWidget {
  AdditionalPage({super.key});

  AdditionalPageState createState() => AdditionalPageState();
}

class AdditionalPageState extends State<AdditionalPage> {
  double ratingVal = 0;
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

  void showRating(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('${AppLocalizations.of(context)!.rateApp}'),
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${AppLocalizations.of(context)!.leaveAStar}'),
                    const SizedBox(
                      height: 32,
                    ),
                    rating(),
                  ]),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('${AppLocalizations.of(context)!.ok}'))
              ],
            ));
  }

  Widget rating() {
    return RatingBar.builder(
      minRating: 1,
      itemSize: 50,
      itemPadding: EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, _) => Icon(Icons.star),
      updateOnDrag: true,
      onRatingUpdate: (rating) => setState(() {
        this.ratingVal = ratingVal;
      }),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              showRating(context);
            },
            child: Text('${AppLocalizations.of(context)!.rateApp}')),
        ElevatedButton(
            onPressed: () {
              Share.share(
                'check out my testing application https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7',
              );
            },
            child: Text('${AppLocalizations.of(context)!.share}')),
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
            child: Text('${AppLocalizations.of(context)!.link}'))
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
