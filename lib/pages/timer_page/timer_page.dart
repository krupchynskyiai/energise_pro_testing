import 'dart:async';

import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Duration duration = Duration();
  Timer? timer;

  bool isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void addTime() {
    final addSecond = 1;

    setState(() {
      final seconds = duration.inSeconds + addSecond;

      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer() {
    setState(() {
      final seconds = duration.inSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTime(),
          controls(),
        ],
      ),
    );
  }

  Widget controls() {
    return isRunning
        ? buttonWidget(text: 'Почати', onClick: startTimer())
        : buttonWidget(text: 'зупинити', onClick: stopTimer());
  }

  Widget buttonWidget({required String text, required void onClick}) {
    return ElevatedButton(
        onPressed: () {
          onClick;
        },
        child: Text('$text'));
  }

  Widget buildTime() {
    String correctDigits(int digit) => digit.toString().padLeft(2, '0');
    final minutes = correctDigits(duration.inMinutes.remainder(60));
    final seconds = correctDigits(duration.inSeconds.remainder(60));

    return Row(
      children: [
        timeBox(timeAmount: minutes, cardName: 'MINUTES'),
        const SizedBox(
          width: 8,
        ),
        const Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
            fontSize: 72,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        timeBox(timeAmount: seconds, cardName: 'SECONDS'),
      ],
    );
  }

  Widget timeBox({required String timeAmount, required String cardName}) {
    return Text(
      timeAmount,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.black,
        fontSize: 72,
      ),
    );
  }
}
