import 'package:energise_pro_testing/pages/additional_page/additional_page.dart';
import 'package:energise_pro_testing/pages/change_language_page/change_language_page.dart';
import 'package:energise_pro_testing/pages/ip_location_page/ip_location_page.dart';
import 'package:energise_pro_testing/pages/timer_page/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:energise_pro_testing/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  bool isEnglish = true;

  void _toggleLanguage() {
    setState(() {
      isEnglish = !isEnglish;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: TabBarWidget(lang: isEnglish, toggleLanguage: _toggleLanguage),
      supportedLocales: L10n.all,
      locale: isEnglish ? const Locale('en') : const Locale('de'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}

class TabBarWidget extends StatefulWidget {
  const TabBarWidget(
      {super.key, required this.lang, required this.toggleLanguage});
  final VoidCallback toggleLanguage;
  final bool lang;

  @override
  TabBarState createState() => TabBarState();
}

class TabBarState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: SvgPicture.asset(
                  'assets/icons/clock.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/icons/internet.svg',
                  height: 20,
                  width: 20,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/icons/gear.svg',
                  height: 20,
                  width: 20,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/icons/translate.svg',
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const TimerPage(),
            const IPLocation(),
            const AdditionalPage(),
            ChangeLanguage(
                lang: widget.lang,
                onChangeLanguage: (newLang) {
                  widget.toggleLanguage();
                })
          ],
        ),
      ),
    );
  }
}
