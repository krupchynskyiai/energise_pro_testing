import 'package:energise_pro_testing/pages/additional_page/additional_page.dart';
import 'package:energise_pro_testing/pages/ip_location_page/ip_location_page.dart';
import 'package:energise_pro_testing/pages/timer_page/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: const TabBarWidget());
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
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
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            TimerPage(),
            IPLocation(),
            AdditionalPage(),
          ],
        ),
      ),
    );
  }
}
