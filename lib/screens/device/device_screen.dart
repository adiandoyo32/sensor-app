import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/device/device_list.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sensor_app/services/device_service.dart';

class DeviceScreen extends StatefulWidget {
  static const String routeName = "device_screen";
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  String qrResult = '';
  var response;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () => _refreshDevices(context),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
              child: Row(
                children: [
                  Consumer<Devices>(
                    builder: (context, devices, _) => RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${devices.deviceCount} ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                devices.deviceCount > 1 ? 'devices' : 'device',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : DeviceList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () async {
          qrResult = await scanner.scan();
          if (qrResult == null) {
            return;
          }
          response = await DeviceService().connectDevice(qrResult);
          if (response['code'] == 200) {
            _refreshDevices(context);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Device added'),
              duration: Duration(seconds: 3),
              action: SnackBarAction(
                label: 'Close',
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                },
              ),
            ));
          } else if (response['code'] == 400) {
            _showMaterialDialog(response['error']);
          } else {
            _showMaterialDialog(response['error']['device_id'][0]);
          }
        },
      ),
    );
  }

  _showMaterialDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Failed to add device"),
        content: new Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
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
