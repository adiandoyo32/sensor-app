import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sensor_app/constants/colors.dart';

class DeviceTypeModel {
  String getSymbol(String type) {
    String symbol;
    switch (type) {
      case "turbidity":
        symbol = "NTUs";
        break;
      case "temperature":
        symbol = "°C";
        break;
      case "ldr":
        symbol = "cd";
        break;
      case "flow":
        symbol = "L/min";
        break;
      case "ph":
        symbol = "pH";
        break;
      default:
        symbol = "";
    }
    return symbol;
  }

  Color getColor(String type) {
    Color color;
    switch (type) {
      case "turbidity":
        color = kBrownLightenColor;
        break;
      case "temperature":
        color = kRedLightenColor;
        break;
      case "ldr":
        color = kYellowLightenColor;
        break;
      case "flow":
        color = kBlueLightenColor;
        break;
      case "ph":
        color = kPurpleLightenColor;
        break;
      default:
        color = Colors.black12;
    }
    return color;
  }

  Icon getIcon(String type) {
    Icon icon;
    switch (type) {
      case "turbidity":
        icon = Icon(MdiIcons.wave, color: Colors.brown);
        break;
      case "temperature":
        icon = Icon(MdiIcons.thermometer, color: Colors.red);
        break;
      case "ldr":
        icon = Icon(MdiIcons.lightbulbOn, color: Colors.yellow[800]);
        break;
      case "flow":
        icon = Icon(MdiIcons.waves, color: Colors.blue);
        break;
      case "ph":
        icon = Icon(MdiIcons.waterAlertOutline, color: Colors.purple);
        break;
      default:
        icon = Icon(MdiIcons.help, color: Colors.black54);
    }
    return icon;
  }
}
