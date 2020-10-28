import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/providers/senders.dart';
import 'package:sensor_app/screens/sender/sender_add_screen.dart';
import 'package:sensor_app/screens/sender/widgets/sender_list.dart';

class SenderScreen extends StatefulWidget {
  static const String routeName = "sender_screen";
  @override
  _SenderScreenState createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _isLoading = true;
      Provider.of<Senders>(context).fetchSenders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  Future<void> _refreshSenders(BuildContext context) async {
    await Provider.of<Senders>(context, listen: false).fetchSenders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () => _refreshSenders(context),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
              child: Row(
                children: [
                  Consumer<Senders>(
                    builder: (context, senders, _) => RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '${senders.senderCount} ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'senders',
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
              text: "Sender",
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
