class Sensor {
  double humi;
  double temp;
  double ldrData;
  double voltage;

  Sensor({required this.humi, required this.temp, required this.ldrData, required this.voltage});

  Map<String, dynamic> toJson() {
    return {
      'humi': this.humi,
      'temp': this.temp,
      'ldrData': this.ldrData,
      'voltage': this.voltage,
    };
  }

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      humi: json['humi'] as double,
      temp: json['temp'] as double,
      ldrData: json['ldrData'] as double,
      voltage: json['voltage'] as double,
    );
  }
}