import 'package:energise_pro_testing/pages/ip_location_page/ip_location_page.dart';
import 'package:energise_pro_testing/pages/timer_page/timer_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: IPLocation());
  }
}
