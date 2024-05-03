import 'dart:async';

import 'package:energise_pro_testing/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulsator/pulsator.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  Duration duration = const Duration();
  Timer? timer;
  bool isCounting = false;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    if (!isCounting) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
      isCounting = !isCounting;
    } else {
      setState(() {
        timer?.cancel();
        isCounting = false;
      });
    }
  }

  void addTime() {
    const addSecond = 1;

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
      duration = const Duration(minutes: 0, seconds: 0);
    });
  }

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTime(minutes: duration.inMinutes, seconds: duration.inSeconds),
            controls(),
          ],
        ),
      ),
    );
  }

  Widget buildTime({required minutes, required seconds}) {
    String correctDigits(int digit) => digit.toString().padLeft(2, '0');
    final minutes = correctDigits(duration.inMinutes.remainder(60));
    final seconds = correctDigits(duration.inSeconds.remainder(60));
    final hours = correctDigits(duration.inHours.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        timeBox(
            timeAmount: hours, cardName: AppLocalizations.of(context)!.hours),
        const SizedBox(
          width: 8,
        ),
        const Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 72,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        timeBox(
            timeAmount: minutes,
            cardName: AppLocalizations.of(context)!.minutes),
        const SizedBox(
          width: 8,
        ),
        const Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 72,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        timeBox(
            timeAmount: seconds,
            cardName: AppLocalizations.of(context)!.seconds),
      ],
    );
  }

  Widget timeBox({required String timeAmount, required String cardName}) {
    return Text(
      timeAmount,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: 72,
      ),
    );
  }

  Widget controls() {
    return isRunning
        ? Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ButtonTemplate(
                linkOrText: 'assets/icons/pause.svg',
                isImage: true,
                functionGot: () {
                  startTimer();
                  setState(() {
                    isRunning = false;
                  });
                },
              ),
            ]),
          )
        : duration.inMinutes > 0 || duration.inSeconds > 0
            ? Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ButtonTemplate(
                    linkOrText: 'assets/icons/play_bk.svg',
                    isImage: true,
                    functionGot: () {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ButtonTemplate(
                    linkOrText: 'assets/icons/refresh.svg',
                    isImage: true,
                    functionGot: () {
                      reset();
                    },
                  )
                ]),
              )
            : Expanded(
                child: Pulsator(
                  style: const PulseStyle(
                      color: Color(0xff870160),
                      borderColor: Colors.white,
                      borderWidth: 4,
                      gradientStyle: PulseGradientStyle(
                          startColor: Colors.white,
                          start: 0.5,
                          reverseColors: true)),
                  count: 5,
                  duration: const Duration(seconds: 5),
                  autoStart: true,
                  fit: PulseFit.contain,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/icons/play.svg',
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              );
  }
}
