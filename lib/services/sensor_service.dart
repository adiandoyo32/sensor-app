import 'package:sensor_app/models/sensor_model.dart';
import 'package:sensor_app/services/api_services.dart';

const String _BASE_URL = 'http://10.0.2.2:3000';

class SensorService {
  Future<List<Sensor>> getSensors() async {
    try {
      ApiService apiService = ApiService('$_BASE_URL/sensors');
      List<dynamic> responseJson = await apiService.getData();
      List<Sensor> sensors =
          responseJson.map((sensor) => Sensor.fromJson(sensor)).toList();
      return sensors;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<void> createSensor() async {
    try {
      ApiService apiService = ApiService('$_BASE_URL/sensors');
      // final response = await apiService.
    } catch (error) {}
  }
}
