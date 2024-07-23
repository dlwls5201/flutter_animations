import 'dart:math';

import 'package:flutter/material.dart';

class AssignmentScreen4 extends StatefulWidget {
  const AssignmentScreen4({super.key});

  @override
  State<AssignmentScreen4> createState() => _AssignmentScreen4State();
}

class _AssignmentScreen4State extends State<AssignmentScreen4> with TickerProviderStateMixin {
  late final size = MediaQuery
      .of(context)
      .size;

  late final AnimationController _flipCard = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
    setState(() {
      if (_position.value > 0) {
        _backgroundColor = Colors.green;
      } else {
        _backgroundColor = Colors.orange;
      }
    });
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index + 1;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      final factor = _position.value.isNegative ? -1 : 1;
      _position
          .animateTo(
        (dropZone) * factor,
        curve: Curves.easeOut,
      )
          .whenComplete(_whenComplete);
    } else {
      _position.animateTo(
        0,
        curve: Curves.easeOut,
      );
    }

    setState(() {
      _backgroundColor = Colors.blue;
    });
  }

  var _isFlippingCard = false;
  var _isAnswer = false;

  void _onCardTap() {
    setState(() {
      _isFlippingCard = true;
      _isAnswer = !_isAnswer;
    });

    _flipCard.forward().whenComplete(() =>
    {
      setState(() {
        _isFlippingCard = false;
      }),
      _flipCard.value = 0,
    });
  }

  @override
  void dispose() {
    _flipCard.dispose();
    _position.dispose();
    super.dispose();
  }

  int _index = 1;
  var _backgroundColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text("Assignment"),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle =
              _rotation.transform((_position.value + size.width / 2) / size.width) * pi / 180;
          final scale = _scale.transform(_position.value.abs() / size.width);
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: min(scale, 1.0),
                  child: Card(
                    index: _index == 5 ? 1 : _index + 1,
                    isFlippingCard: false,
                    isAnswer: false,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  onTap: _onCardTap,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle,
                      child: AnimatedBuilder(
                        animation: _flipCard,
                        builder: (context, child) {
                          final flipCardAngle = _flipCard.value * 3.14159;
                          final transform = Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(flipCardAngle);
                          return Transform(
                            transform: transform,
                            alignment: Alignment.center,
                            child: Card(
                              index: _index,
                              isFlippingCard: _isFlippingCard,
                              isAnswer: _isAnswer,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: CustomPaint(
                  painter: ProgressIndicatorPainter(index: _index),
                  size: const Size(300, 10),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProgressIndicatorPainter extends CustomPainter {
  final int index;

  ProgressIndicatorPainter({required this.index});

  @override
  void paint(Canvas canvas, Size size) {
    /*final rect = Rect.fromLTWH(0, 0, size.width, size.height); // (x, y, width, height)
    canvas.drawRect(
      rect,
      backgroundPaint,
    );*/

    final backgroundPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    final rrect = RRect.fromLTRBR(
      0, // x 위치
      0, // y 위치
      size.width, // x + width
      size.height, // y + height
      const Radius.circular(20), // 모서리의 반지름
    );

    canvas.drawRRect(rrect, backgroundPaint);

    // fill
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final piece = size.width / 5;
    final fillRrect = RRect.fromLTRBR(
      0, // x 위치
      0, // y 위치
      piece * index, // x + width
      size.height, // y + height
      const Radius.circular(20), // 모서리의 반지름
    );

    canvas.drawRRect(fillRrect, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Card extends StatelessWidget {
  final int index;
  final bool isFlippingCard, isAnswer;

  const Card({
    super.key,
    required this.index,
    required this.isFlippingCard,
    required this.isAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Center(
          child: isFlippingCard
              ? Container()
              : Text(
            isAnswer ? "Answer $index" : "Question $index",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 48,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
