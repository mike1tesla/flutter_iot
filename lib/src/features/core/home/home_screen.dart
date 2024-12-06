import 'dart:math' as math;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_app/src/features/core/home/bloc/home_cubit.dart';
import 'package:iot_app/src/models/sensor.dart';
import 'package:iot_app/src/repositories/data_source/firebase_database_service.dart';

import 'my_sensor_card.dart';

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
  double humi = 0, temp = 0;
  List<double> listTemp = [], listHumi = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildChartDHT(),
              _setLedWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setLedWidget() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    );
  }

  Widget buildChartDHT() {
    return StreamBuilder(
      stream: FirebaseDatabase.instance
          .ref('Sensor/DHT')
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError && snapshot.data?.snapshot.value != null) {
          // print(snapshot.data?.snapshot.value.toString());
          var dht = DHT.fromJson(snapshot.data!.snapshot.value as Map<dynamic, dynamic>);
          humi = dht.humi;
          temp = dht.temp;
          listHumi.add(dht.humi);
          listTemp.add(dht.temp);
          // print('DHT: humi -> ${dht.humi}, temp -> ${dht.temp}');
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: MySensorCard(
                  value: humi,
                  unit: '%',
                  name: 'Humidity',
                  trendData: listHumi,
                  linePoint: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: MySensorCard(
                  value: temp,
                  unit: '\'C',
                  name: 'Temperature',
                  trendData: listTemp,
                  linePoint: Colors.redAccent,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
