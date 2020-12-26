import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:sensor_app/models/device_log_model.dart';
import 'package:sensor_app/providers/devices.dart';

class DeviceChart extends StatefulWidget {
  @override
  _DeviceChartState createState() => _DeviceChartState();
}

class _DeviceChartState extends State<DeviceChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Device Logs",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<Devices>(
                builder: (context, devices, _) => Expanded(
                  child: new charts.TimeSeriesChart(
                    _getSeriesData(devices.logs),
                    animate: true,
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                        tickProviderSpec:
                            new charts.BasicNumericTickProviderSpec(
                                zeroBound: false)),
                    domainAxis: new charts.DateTimeAxisSpec(
                      tickFormatterSpec:
                          new charts.AutoDateTimeTickFormatterSpec(
                        minute: new charts.TimeFormatterSpec(
                          format: 'mm', // or even HH:mm here too
                          transitionFormat: 'hh:mm:ss',
                        ),
                        // day: new charts.TimeFormatterSpec(
                        //     format: 'mm', transitionFormat: 'dd hh:mm:ss'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0x338A959E),
                offset: Offset(0, 15),
                blurRadius: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _getSeriesData(data) {
    List<charts.Series<DeviceLog, DateTime>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (DeviceLog series, _) => series.date,
          measureFn: (DeviceLog series, _) => series.value,
          colorFn: (DeviceLog series, _) =>
              charts.MaterialPalette.blue.shadeDefault),
    ];
    return series;
  }
}
