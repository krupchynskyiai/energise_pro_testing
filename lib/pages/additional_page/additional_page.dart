import 'dart:async';

import 'package:energise_pro_testing/components/button.dart';
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
              title: Text(AppLocalizations.of(context)!.rateApp),
              content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.leaveAStar),
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
                    child: Text(AppLocalizations.of(context)!.ok))
              ],
            ));
  }

  Widget rating() {
    return RatingBar.builder(
      minRating: 1,
      itemSize: 25,
      itemPadding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, _) => const Icon(Icons.star),
      updateOnDrag: true,
      onRatingUpdate: (rating) => setState(() {
        ratingVal = ratingVal;
      }),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0xff1f005c),
            Color(0xff5b0060),
            Color(0xff870160),
            Color(0xffac255e),
            Color(0xffca485c),
            Color(0xffe16b5c),
            Color(0xfff39060),
            Color(0xffffb56b),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTemplate(
            linkOrText: AppLocalizations.of(context)!.rateApp,
            isImage: false,
            functionGot: () {
              showRating(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonTemplate(
            linkOrText: AppLocalizations.of(context)!.share,
            isImage: false,
            functionGot: () {
              Share.share(
                'check out my testing application https://energise.notion.site/Flutter-f86d340cadb34e9cb1ef092df4e566b7',
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonTemplate(
            linkOrText: AppLocalizations.of(context)!.link,
            isImage: false,
            functionGot: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(title: const Text('Testing Task')),
                            body: WebViewWidget(controller: controller),
                          )));
            },
          ),
        ],
      ),
    );
  }
}
