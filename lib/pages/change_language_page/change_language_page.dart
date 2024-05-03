import 'package:energise_pro_testing/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage(
      {super.key, required this.lang, required this.onChangeLanguage});
  final bool lang;
  final ValueChanged<bool> onChangeLanguage;

  @override
  ChangeLanguageState createState() => ChangeLanguageState();
}

class ChangeLanguageState extends State<ChangeLanguage> {
  @override
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
      child: Center(
        child: ButtonTemplate(
          linkOrText: AppLocalizations.of(context)!.changeLanguage,
          isImage: false,
          functionGot: () {
            setState(() {
              bool newLang = !widget.lang;
              widget.onChangeLanguage(newLang);
            });
          },
        ),
      ),
    );
  }
}
