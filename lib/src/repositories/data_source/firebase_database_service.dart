import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {

  Future<void> setDataLedAnalog (double analog) async {
    DatabaseReference ledRef = FirebaseDatabase.instance.ref("Led");
    await ledRef.update({
      "analog": analog,
    });
  }

  Future<void> setDataLedDigital (bool digital) async {
    DatabaseReference ledRef = FirebaseDatabase.instance.ref("Led");
    await ledRef.update({
      "digital": digital,
    });
  }

  Future<void> getDataSensor ()  async {
    DatabaseReference sensorRef = FirebaseDatabase.instance.ref();
    final snapshot = await sensorRef.child('Sensor').get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }
}