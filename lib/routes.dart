import 'package:flutter/material.dart';
import 'package:sensor_app/base_screen.dart';
import 'package:sensor_app/screens/auth/login_screen.dart';
import 'package:sensor_app/screens/device/device_detail_screen.dart';
import 'package:sensor_app/screens/sender/sender_add_screen.dart';
import 'package:sensor_app/screens/sender/sender_detail_location.dart';
import 'package:sensor_app/screens/sender/widgets/sender_pick_location.dart';
import 'package:sensor_app/screens/sensor/sensor_add_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var builder;
  switch (settings.name) {
    case LoginScreen.routeName:
      builder = (_) => LoginScreen();
      break;
    case BaseScreen.routeName:
      builder = (_) => BaseScreen();
      break;
    case DeviceDetailScreen.routeName:
      var deviceId = settings.arguments;
      builder = (_) => DeviceDetailScreen(deviceId);
      break;
    case SenderAddScreen.routeName:
      builder = (_) => SenderAddScreen();
      break;
    case SenderPickLocation.routeName:
      builder = (_) => SenderPickLocation();
      break;
    case SenderDetailLocation.routeName:
      var coord = settings.arguments;
      builder = (_) => SenderDetailLocation(coord);
      break;
    case SensorAddScreen.routeName:
      builder = (_) => SensorAddScreen();
      break;
    default:
      builder = (_) => BaseScreen();
  }
  return MaterialPageRoute(builder: builder);
}
