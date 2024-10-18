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
              child: const Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 16),),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 55),
              ),
            ),
            const SizedBox(height: 16), // Khoảng cách giữa hai nút
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SignUpScreen.route);
              },
              child: const Text("CREATE ACCOUNT", style: TextStyle(fontSize: 16),),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: Size(double.infinity, 55),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
