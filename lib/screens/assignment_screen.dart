import 'dart:async';

import 'package:flutter/material.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  bool _changeState = true;
  final _animationDurationSecond = 1;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: _animationDurationSecond), (timer) {
      setState(() {
        _changeState = !_changeState;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _changeState ? Colors.grey.shade300 : Colors.black,
      appBar: AppBar(
        title: const Text("Assignment"),
      ),
      body: Center(
          child: SizedBox(
        width: size.width * 0.6,
        height: size.width * 0.6,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: _changeState ? BoxShape.circle : BoxShape.rectangle,
              ),
            ),
            AnimatedAlign(
              alignment: _changeState ? Alignment.topLeft : Alignment.topRight,
              duration: Duration(seconds: _animationDurationSecond),
              child: Container(
                width: 15,
                color: _changeState ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
