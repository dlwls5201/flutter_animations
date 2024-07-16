import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/assignment_screen.dart';

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
                  const AssignmentScreen(),
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
