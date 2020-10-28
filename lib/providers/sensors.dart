import 'package:flutter/foundation.dart';
import 'package:sensor_app/models/sensor_model.dart';
import 'package:sensor_app/services/sensor_service.dart';

class Sensors with ChangeNotifier {
  SensorService sensorService = SensorService();

  List<Sensor> _sensors = [];

  List<Sensor> get sensors => [..._sensors];

  int get sensorCount {
    return _sensors.length;
  }

  Sensor findById(int id) {
    return _sensors.firstWhere((element) => element.id == id);
  }

  int findLastId() {
    Sensor sender = _sensors.last;
    return sender.id;
  }

  Future<void> fetchSensors() async {
    // _setState(SenderState.loading);
    try {
      List<Sensor> fetchedSensors = await sensorService.getSensors();
      _sensors = fetchedSensors;
      notifyListeners();
    } catch (error) {
      // _setFailure(error);
      throw Exception(error.toString());
    }
    // _setState(SenderState.loaded);
  }

  void deleteSensor(int id) {
    _sensors.removeWhere((sensor) => sensor.id == id);
    notifyListeners();
  }
}
