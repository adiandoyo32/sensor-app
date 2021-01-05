import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/devices.dart';

class DeviceFilter extends StatefulWidget {
  final Map<String, dynamic> selectedFilter;
  final Function(Map) onSelected;

  const DeviceFilter(this.selectedFilter, {this.onSelected});

  @override
  _DeviceFilterState createState() => _DeviceFilterState();
}

class _DeviceFilterState extends State<DeviceFilter> {
  List _listStatus = ["All", "Active", "Inactive"];
  List _listType = ["All", "Turbidity", "Temperature", "LDR", "Flow", "pH"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1, child: Text('Status')),
              Flexible(
                flex: 2,
                child: Consumer<Devices>(
                  builder: (context, devices, _) => DropdownButton(
                    isExpanded: true,
                    hint: Text("Status"),
                    value: devices.filter['status'],
                    items: _listStatus.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      devices.setFilterStatus(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1, child: Text('Type')),
              Flexible(
                flex: 2,
                child: Consumer<Devices>(
                  builder: (context, devices, _) => DropdownButton(
                    isExpanded: true,
                    hint: Text("Device Type"),
                    // value: widget.selectedFilter['type'],
                    value: devices.filter['type'],
                    items: _listType.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      devices.setFilterType(value);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
