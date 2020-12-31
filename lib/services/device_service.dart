import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/models/device_type_count_model.dart';
import 'package:sensor_app/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _BASE_URL = "http://api.sensorku.tafexclusive.site/api";

class DeviceService {
  Future<String> getUserId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String id = localStorage.getString('userId');
    return id;
  }

  Future<List<Device>> getDevices() async {
    String id = await getUserId();

    try {
      ApiService apiService = ApiService('$_BASE_URL/users/$id/devices');
      Map<String, dynamic> responseJson = await apiService.getData();
      List<dynamic> data = responseJson["data"];
      List<Device> devices =
          data.map((device) => Device.fromJson(device)).toList();
      print(devices);
      return devices;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<List<DeviceTypeCount>> getDeviceTypeCount() async {
    String id = await getUserId();
    try {
      ApiService apiService = ApiService('$_BASE_URL/users/$id/devices/count');
      Map<String, dynamic> responseJson = await apiService.getData();
      List<dynamic> data = responseJson["data"];
      List<DeviceTypeCount> deviceTypes = data
          .map((deviceType) => DeviceTypeCount.fromJson(deviceType))
          .toList();
      return deviceTypes;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<dynamic> connectDevice(String deviceId) async {
    String id = await getUserId();

    Map<String, dynamic> body = {"device_id": deviceId};
    try {
      ApiService apiService =
          ApiService('$_BASE_URL/users/$id/connect-devices');
      Map<String, dynamic> responseJson = await apiService.patchData(body);
      return responseJson;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<dynamic> disconnectDevice(int id) async {
    String id = await getUserId();

    Map<String, dynamic> body = {"id": id};
    try {
      ApiService apiService =
          ApiService('$_BASE_URL/users/$id/disconnect-devices');
      Map<String, dynamic> responseJson = await apiService.patchData(body);
      return responseJson;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
