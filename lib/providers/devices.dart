import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sensor_app/models/device_model.dart';
import 'package:sensor_app/models/device_log_model.dart';
import 'package:sensor_app/models/device_type_count_model.dart';
import 'package:sensor_app/services/device_service.dart';

class Devices with ChangeNotifier {
  DeviceService deviceService = DeviceService();

  List<Device> _devices = [];
  List<DeviceLog> _logs = [];
  List<DeviceTypeCount> _deviceTypes = [];
  String _deviceCurrentLog = "";

  List<Device> get devices {
    return [..._devices];
  }

  List<DeviceLog> get logs {
    return [..._logs];
  }

  List<DeviceTypeCount> get deviceTypes {
    return [..._deviceTypes];
  }

  int get deviceCount {
    return _devices.length;
  }

  int get activeDeviceCount {
    return _devices.where((element) => element.isActive == 1).length;
  }

  void setDeviceCurrentLog(String val) {
    _deviceCurrentLog = val;
    notifyListeners();
  }

  String get deviceCurrentLog {
    return _deviceCurrentLog;
  }

  void resetLog() {
    _logs = [];
    notifyListeners();
  }

  void addData(log) {
    if (_logs.length > 20) {
      _logs.removeAt(0);
    }
    DateTime dateTime =
        new DateFormat("yyyy-MM-dd hh:mm:ss").parse(log['created_at']);
    _logs.add(DeviceLog(dateTime, double.parse(log['value'])));
    notifyListeners();
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
      throw Exception(error.toString());
    }
  }

  Future<void> fetchDeviceTypeCount() async {
    try {
      List<DeviceTypeCount> fetchedDeviceTypes =
          await deviceService.getDeviceTypeCount();
      _deviceTypes = fetchedDeviceTypes;
      notifyListeners();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<void> deleteDevice(int id) async {
    await deviceService.disconnectDevice(id);
    _devices.removeWhere((device) => device.id == id);
    notifyListeners();
  }
}
