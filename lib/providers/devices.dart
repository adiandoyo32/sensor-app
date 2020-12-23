import 'package:flutter/foundation.dart';
import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/services/device_service.dart';

class Devices with ChangeNotifier {
  DeviceService deviceService = DeviceService();

  List<Device> _devices = [];

  List<Device> get devices {
    return [..._devices];
  }

  int get deviceCount {
    return _devices.length;
  }

  Device findById(int id) {
    return _devices.firstWhere((element) => element.id == id);
  }

  int findLastId() {
    Device device = _devices.last;
    return device.id;
  }

  Future<void> fetchDevices() async {
    try {
      List<Device> fetchedDevices = await deviceService.getDevices();
      _devices = fetchedDevices;
      notifyListeners();
    } catch (error) {
      // _setFailure(error);
      throw Exception(error.toString());
    }
  }

  Future<void> deleteDevice(int id) async {
    await deviceService.disconnectDevice(id);
    _devices.removeWhere((device) => device.id == id);
    notifyListeners();
  }
}
