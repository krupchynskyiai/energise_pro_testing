import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguage extends StatefulWidget {
  ChangeLanguage(
      {super.key, required this.lang, required this.onChangeLanguage});
  final bool lang;
  final ValueChanged<bool> onChangeLanguage;

  ChangeLanguageState createState() => ChangeLanguageState();
}

class ChangeLanguageState extends State<ChangeLanguage> {
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              bool newLang = !widget.lang;
              widget.onChangeLanguage(newLang);
            });
          },
          child: Text('${AppLocalizations.of(context)!.changeLanguage}')),
    );
  }
}
