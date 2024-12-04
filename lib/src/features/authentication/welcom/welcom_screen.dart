import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/src/features/authentication/login/login_screen.dart';
import 'package:iot_app/src/features/authentication/signup/signup_screen.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.route);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 16),),
            ),
            const SizedBox(height: 16), // Khoảng cách giữa hai nút
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SignUpScreen.route);
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size(double.infinity, 55),
              ),
              child: const Text("CREATE ACCOUNT", style: TextStyle(fontSize: 16),),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
