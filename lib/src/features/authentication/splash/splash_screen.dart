import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/src/features/authentication/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = "SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.lightGreenAccent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset("assets/img/splash.png"),
            ),
            const Positioned(
              bottom: 30,
              child: Text(
                "Design by M1ke",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
