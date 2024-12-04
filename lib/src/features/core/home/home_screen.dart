import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_app/src/repositories/data_source/firebase_database_service.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  bool digital = false; // gan cho gia tri lay tu RTDB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  FirebaseDatabaseService().getDataSensor();
                },
                child: const Text("GET DATA SENSOR"),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    digital = !digital;
                    FirebaseDatabaseService().setDataLedDigital(digital);
                  });
                },
                child: Text("Set Led digital $digital"),
              ),
              TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter analog value';
                  }
                  final analogValue = double.parse(value);
                  if (analogValue < 0 || analogValue > 255) {
                    return "Enter value range 0 to 255";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  bool isValid = _formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    //   Thực hiện CallAPI hoặc Login
                    final analog = double.parse(controller.text);
                    FirebaseDatabaseService().setDataLedAnalog(analog);
                    controller.clear();
                  } else {
                    //   Không làm gì
                  }
                },
                child: const Text("Set Led analog"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
