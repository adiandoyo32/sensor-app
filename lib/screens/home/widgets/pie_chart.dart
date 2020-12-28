import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatefulWidget {
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  final data = [
    GradesData('A', 190, charts.MaterialPalette.red.shadeDefault),
    GradesData('B', 230, charts.MaterialPalette.red.shadeDefault),
    GradesData('C', 150, charts.MaterialPalette.red.shadeDefault),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: double.infinity,
      child: new charts.PieChart(
        _getSeriesData(),
        animate: true,
        defaultRenderer:
            new charts.ArcRendererConfig(arcWidth: 60, arcRendererDecorators: [
          new charts.ArcLabelDecorator(),
        ]),
      ),
    );
  }

  _getSeriesData() {
    List<charts.Series<GradesData, String>> series = [
      charts.Series(
          id: "Grades",
          data: data,
          colorFn: (GradesData segment, _) => segment.color,
          labelAccessorFn: (GradesData row, _) =>
              '${row.gradeSymbol}: ${row.numberOfStudents}',
          domainFn: (GradesData grades, _) => grades.gradeSymbol,
          measureFn: (GradesData grades, _) => grades.numberOfStudents),
    ];
    return series;
  }
}

class GradesData {
  final String gradeSymbol;
  final int numberOfStudents;
  final charts.Color color;

  GradesData(this.gradeSymbol, this.numberOfStudents, this.color);
}
