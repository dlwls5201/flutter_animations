import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() => _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Implicit Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*AnimatedContainer(
              curve: Curves.elasticInOut,
              duration: const Duration(seconds: 2),
              transform: Matrix4.rotationZ(_visible ? 1 : 0),
              transformAlignment: Alignment.center,
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                color: _visible ? Colors.red : Colors.amber,
                borderRadius: BorderRadius.circular(_visible ? 100 : 0),
              ),
            ),*/
            TweenAnimationBuilder(
              tween: ColorTween(
                begin: Colors.blue,
                end: Colors.red,
              ),
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return Image.network(
                  "https://static.wikia.nocookie.net/logopedia/images/8/8d/Dash_mascot_%28Flutter%2C_Dart%29.png/revision/latest/scale-to-width-down/250?cb=20240115061031",
                  color: value,
                  colorBlendMode: BlendMode.colorBurn,
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Go!"),
            ),
          ],
        ),
      ),
    );
  }
}
