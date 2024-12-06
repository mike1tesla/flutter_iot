import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../models/sensor.dart';

Widget buildStreamDataDHT(BuildContext context) {
  late double temp, humi;
  final limitCount = 100;
  final humiPoints = <FlSpot>[];
  final tempPoints = <FlSpot>[];
  double xValue = 0;
  double step = 10;

  return StreamBuilder(
    stream: FirebaseDatabase.instance.ref('Sensor/DHT').onValue,
    builder: (context, snapshot) {
      if(snapshot.hasData && !snapshot.hasError && snapshot.data?.snapshot.value != null){
        print(snapshot.data?.snapshot.value.toString());
        var dht = DHT.fromJson(snapshot.data!.snapshot.value as Map<dynamic, dynamic>);
        humi = dht.humi;
        temp = dht.temp;
        // print('DHT: humi -> ${dht.humi}, temp -> ${dht.temp}');

        while (humiPoints.length > limitCount) {
          humiPoints.removeAt(0);
          tempPoints.removeAt(0);
        }
        humiPoints.add(FlSpot(xValue, humi));
        tempPoints.add(FlSpot(xValue, temp));
        // print(humiPoints);
        xValue += step;
      }
      return humiPoints.isNotEmpty ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Text(
            'x: ${xValue.toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Humi: ${humiPoints.last.y.toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.lightBlue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Temp: ${tempPoints.last.y.toStringAsFixed(1)}',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 100,
                          minX: humiPoints.first.x,
                          maxX: humiPoints.last.x,
                          lineTouchData: const LineTouchData(enabled: false),
                          clipData: const FlClipData.all(),
                          gridData: const FlGridData(
                            show: true,
                            drawVerticalLine: false,
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            humiLine(humiPoints),
                            // tempLine(tempPoints),
                          ],
                          titlesData: const FlTitlesData(
                            show: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: LineChart(
                        LineChartData(
                          minY: 0,
                          maxY: 50,
                          minX: tempPoints.first.x,
                          maxX: tempPoints.last.x,
                          lineTouchData: const LineTouchData(enabled: false),
                          clipData: const FlClipData.all(),
                          gridData: const FlGridData(
                            show: true,
                            drawVerticalLine: false,
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            // humiLine(humiPoints),
                            tempLine(tempPoints),
                          ],
                          titlesData: const FlTitlesData(
                            show: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ): Container();
    },
  );
}

LineChartBarData humiLine(List<FlSpot> points) {
  return LineChartBarData(
    spots: points,
    dotData: const FlDotData(
      show: false,
    ),
    gradient: LinearGradient(
      colors: [Colors.lightBlue.withOpacity(0), Colors.lightBlue],
      stops: const [0.1, 1.0],
    ),
    barWidth: 4,
    isCurved: false,
  );
}

LineChartBarData tempLine(List<FlSpot> points) {
  return LineChartBarData(
    spots: points,
    dotData: const FlDotData(
      show: false,
    ),
    gradient: LinearGradient(
      colors: [Colors.redAccent.withOpacity(0), Colors.redAccent],
      stops: const [0.1, 1.0],
    ),
    barWidth: 4,
    isCurved: false,
  );
}

