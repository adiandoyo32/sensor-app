import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/sender/sender_add_screen.dart';
import 'package:sensor_app/screens/sender/widgets/sender_list.dart';

class DeviceScreen extends StatefulWidget {
  static const String routeName = "device_screen";
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  bool _isInit = true;
  bool _isLoading = false;

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
                            text: 'devices',
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
                // child: Consumer<Senders>(
                //   builder: (_, sender, __) {
                //     if (sender.state == SenderState.initial) {
                //       return Text('Initial');
                //     } else if (sender.state == SenderState.loading) {
                //       return Center(child: CircularProgressIndicator());
                //     } else {
                //       if (sender.failure != null) {
                //         return Text(sender.failure.toString());
                //       } else {
                //         return SenderList();
                //       }
                //     }
                //   },
                // ),child: Expanded(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : SenderList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.pushNamed(context, SenderAddScreen.routeName);
        },
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
