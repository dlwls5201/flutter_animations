import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/explicit_animations_screens.dart';

import 'apple_watch_screen.dart';
import 'assignment/assignment_screen_3.dart';
import 'implicit_animations_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flutter Animations"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                goToPage(
                  context,
                  const ImplicitAnimationsScreen(),
                );
              },
              child: const Text(
                "Implicit Animations",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                goToPage(
                  context,
                  const ExplicitAnimationsScreen(),
                );
              },
              child: const Text(
                "Explicit Animations",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                goToPage(
                  context,
                  const AppleWatchScreen(),
                );
              },
              child: const Text(
                "Apple Watch",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                goToPage(
                  context,
                  const AssignmentScreen3(),
                );
              },
              child: const Text(
                "Assignment Animations",
              ),
            )
          ],
        ),
      ),
    );
  }
}
