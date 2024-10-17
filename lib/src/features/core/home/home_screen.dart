import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String route = "HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text(route),);
  }
}
