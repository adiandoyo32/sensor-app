import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/services/api_services.dart';

const String _BASE_URL = "http://api.sensorku.tafexclusive.site";

class DeviceService {
  Future<List<Device>> getDevices() async {
    try {
      ApiService apiService = ApiService('$_BASE_URL/api/users/1/devices');
      Map<String, dynamic> responseJson = await apiService.getData();
      List<dynamic> data = responseJson["data"];
      List<Device> devices =
          data.map((device) => Device.fromJson(device)).toList();
      return devices;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
