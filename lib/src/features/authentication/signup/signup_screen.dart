import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {

  static const String route = "SignUpScreen";
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Center(child: Text("SignUpScreen")),
    );
  }
}
