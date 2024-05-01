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
  bool isCounting = false;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    if (!isCounting) {
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
      isCounting = !isCounting;
    } else {
      setState(() {
        timer?.cancel();
        isCounting = false;
      });
    }
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
      timer?.cancel();
    });
  }

  void reset() {
    setState(() {
      duration = Duration(minutes: 0, seconds: 0);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildTime(minutes: duration.inMinutes, seconds: duration.inSeconds),
          controls(),
        ],
      ),
    );
  }

  Widget buildTime({required minutes, required seconds}) {
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

  Widget controls() {
    return isRunning
        ? Row(children: [
            ElevatedButton(
              onPressed: () {
                startTimer();
                setState(() {
                  isRunning = false;
                });
              },
              child: Text('Зупинити'),
            )
          ])
        : duration.inMinutes > 0 || duration.inSeconds > 0
            ? Row(children: [
                ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = false;
                    });
                  },
                  child: Text('Продовжити'),
                ),
                ElevatedButton(
                  onPressed: () {
                    reset();
                  },
                  child: Text('Обнулити'),
                )
              ])
            : Row(children: [
                ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: Text('Почати'),
                )
              ]);
  }
}
