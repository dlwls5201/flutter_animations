import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AssignmentScreen3 extends StatefulWidget {
  const AssignmentScreen3({super.key});

  @override
  State<AssignmentScreen3> createState() => _AssignmentScreen3State();
}

class _AssignmentScreen3State extends State<AssignmentScreen3> {
  static const DEFAULT_TIMER_COUNT = 300;
  static const DEFAULT_TIMER_TEXT = "05:00";

  bool isPlay = false;
  int timerCount = DEFAULT_TIMER_COUNT;
  String timerText = DEFAULT_TIMER_TEXT;

  late Timer _timer;

  String _getTimerText(int count) {
    int minute = count ~/ 60;
    int second = count % 60;

    final minuteText = minute > 9 ? "$minute" : "0$minute";
    final secondText = second > 9 ? "$second" : "0$second";

    return "$minuteText:$secondText";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void onRefresh() {
    setState(() {
      timerCount = DEFAULT_TIMER_COUNT;
      timerText = DEFAULT_TIMER_TEXT;
      isPlay = false;
      _timer.cancel();
    });
  }

  void onPlay() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCount--;

      if (timerCount < 0) {
        onStop();
        timer.cancel();
        return;
      }

      setState(() {
        timerText = _getTimerText(timerCount);
      });
    });

    setState(() {
      isPlay = true;
    });
  }

  void onPause() {
    _timer.cancel();
    setState(() {
      isPlay = false;
    });
  }

  void onStop() {
    setState(() {
      timerCount = 0;
      timerText = "00:00";
      isPlay = false;
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignment")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 96,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: PomodoroPainter(progress: timerCount),
                size: const Size(300, 300),
              ),
              Text(
                timerText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onRefresh,
                icon: const Icon(
                  Icons.replay_circle_filled,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: isPlay ? onPause : onPlay,
                icon: Icon(
                  isPlay ? Icons.pause_circle_outline : Icons.play_circle_outline,
                  size: 80,
                ),
              ),
              IconButton(
                onPressed: onStop,
                icon: const Icon(
                  Icons.stop_circle,
                  size: 40,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PomodoroPainter extends CustomPainter {
  final int progress;

  PomodoroPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final circleRadius = (size.width / 2) * 1;

    // grey circle
    final circlePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, circleRadius, circlePaint);

    // red arc
    const startingAngle = -0.5 * pi;

    final redArcRect = Rect.fromCircle(
      center: center,
      radius: circleRadius,
    );

    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    // progress -> 300 ~ 0 까지의 숫자를 반환 한다.
    final parsedProgress = (300 - progress) / 150;

    canvas.drawArc(
      redArcRect,
      startingAngle,
      parsedProgress * pi,
      false,
      redArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
