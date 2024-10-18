import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatelessWidget {
  static const String route = "WelcomScreen";

  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: OutlinedButton(
                  onPressed: (){},
                  child: const Text("Create Account"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
