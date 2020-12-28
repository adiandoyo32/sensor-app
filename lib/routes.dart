import 'package:flutter/material.dart';
import 'package:sensor_app/base_screen.dart';
import 'package:sensor_app/screens/auth/login_screen.dart';
import 'package:sensor_app/screens/device/device_add.dart';
import 'package:sensor_app/screens/device/device_detail/device_detail_screen.dart';
import 'package:sensor_app/screens/device/device_location.dart';
import 'package:sensor_app/screens/sender/widgets/sender_pick_location.dart';
import 'package:sensor_app/screens/sensor/sensor_add_screen.dart';
import 'package:sensor_app/screens/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var builder;
  switch (settings.name) {
    case SplashScreen.routeName:
      builder = (_) => SplashScreen();
      break;
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
    case DeviceLocation.routeName:
      var coord = settings.arguments;
      builder = (_) => DeviceLocation(coord);
      break;
    case DeviceAdd.routeName:
      builder = (_) => DeviceAdd();
      break;
    case SenderPickLocation.routeName:
      builder = (_) => SenderPickLocation();
      break;
    case SensorAddScreen.routeName:
      builder = (_) => SensorAddScreen();
      break;
    default:
      builder = (_) => BaseScreen();
  }
  return MaterialPageRoute(builder: builder);
}
