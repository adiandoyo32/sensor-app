import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/screens/device/device_filter.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/device/device_overview_list.dart';

class DeviceOverviewScreen extends StatefulWidget {
  @override
  _DeviceOverviewScreenState createState() => _DeviceOverviewScreenState();
}

class _DeviceOverviewScreenState extends State<DeviceOverviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isInit = true;
  bool _isLoading = false;
  Map<String, dynamic> selectedFilter = {
    "status": "All",
    "type": "All",
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _isLoading = true;
      Provider.of<Devices>(context).fetchDevices().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  Future<void> _refreshDevices(BuildContext context) async {
    await Provider.of<Devices>(context, listen: false).fetchDevices();
  }

  void filterDevice() {
    Provider.of<Devices>(context, listen: false).filterDevice();
  }

  _showFilterDialog() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter Device"),
          content: DeviceFilter(selectedFilter, onSelected: (selected) {
            Provider.of<Devices>(context, listen: false)
                .setFilterStatus(selected['status']);
            Provider.of<Devices>(context, listen: false)
                .setFilterType(selected['type']);
          }),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Apply"),
              onPressed: () {
                filterDevice();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () => _refreshDevices(context),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<Devices>(
                    builder: (context, devices, _) => RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${devices.filteredDeviceCount} ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: devices.deviceCount > 1
                                ? 'devices '
                                : 'device ',
                            style: TextStyle(fontSize: 14),
                          ),
                          devices.isFiltered
                              ? TextSpan(
                                  text: '(Filtered)',
                                  style: TextStyle(fontSize: 14),
                                )
                              : TextSpan()
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Text('Filter'),
                    ),
                    onTap: () {
                      _showFilterDialog();
                    },
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : DeviceOverviewList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
              ),
          children: [
            TextSpan(text: "My "),
            TextSpan(
              text: "Device",
              style: TextStyle(
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
    );
  }
}
