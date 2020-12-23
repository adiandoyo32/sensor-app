import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/services/api_services.dart';

const String _BASE_URL = "http://api.sensorku.tafexclusive.site/api";

class DeviceService {
  Future<List<Device>> getDevices() async {
    try {
      ApiService apiService = ApiService('$_BASE_URL/users/1/devices');
      Map<String, dynamic> responseJson = await apiService.getData();
      List<dynamic> data = responseJson["data"];
      List<Device> devices =
          data.map((device) => Device.fromJson(device)).toList();
      return devices;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<dynamic> connectDevice(String deviceId) async {
    Map<String, dynamic> body = {"device_id": deviceId};
    try {
      ApiService apiService = ApiService('$_BASE_URL/users/1/connect-devices');
      Map<String, dynamic> responseJson = await apiService.patchData(body);
      return responseJson;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<dynamic> disconnectDevice(int id) async {
    Map<String, dynamic> body = {"id": id};
    try {
      ApiService apiService =
          ApiService('$_BASE_URL/users/1/disconnect-devices');
      Map<String, dynamic> responseJson = await apiService.patchData(body);
      return responseJson;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
