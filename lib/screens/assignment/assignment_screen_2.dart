import 'dart:async';

import 'package:flutter/material.dart';

class AssignmentScreen2 extends StatefulWidget {
  const AssignmentScreen2({super.key});

  @override
  State<AssignmentScreen2> createState() => _AssignmentScreen2State();
}

class _AssignmentScreen2State extends State<AssignmentScreen2> with SingleTickerProviderStateMixin {
  final _animationDuration = 1000;
  final List<bool> _decorations = [];
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 25; i++) {
      _decorations.add(false);
    }

    for (int i = 0; i < 25; i++) {
      Future.delayed(Duration(milliseconds: 50 * i), () {
        _timers.add(
          Timer.periodic(Duration(milliseconds: _animationDuration), (timer) {
            setState(() {
              _decorations[i] = !_decorations[i];
            });
          }),
        );
      });
    }
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Assignment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 24; i >= 20; i--)
                    AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _decorations[i] ? Colors.red : Colors.transparent,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 15; i < 20; i++)
                    AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _decorations[i] ? Colors.red : Colors.transparent,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 14; i >= 10; i--)
                    AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _decorations[i] ? Colors.red : Colors.transparent,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 5; i < 10; i++)
                    AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _decorations[i] ? Colors.red : Colors.transparent,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 4; i >= 0; i--)
                    AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _decorations[i] ? Colors.red : Colors.transparent,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
