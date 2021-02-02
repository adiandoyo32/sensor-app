import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensor_app/providers/devices.dart';
import 'package:sensor_app/screens/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "profile_screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences sharedPreferences;
  String id, username, email;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      setState(() {
        id = sharedPreferences.getString('userId');
        username = sharedPreferences.getString('username');
        email = sharedPreferences.getString('email');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
            children: [
              TextSpan(text: "Profile "),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                  title: new Text("Log out from application?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Log Out'),
                      onPressed: () {
                        logout();
                      },
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              SizedBox(height: 32),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://via.placeholder.com/150"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Divider(height: 0, color: Color(0x40121212)),
              ListTile(
                title: Text('Username'),
                subtitle: username != null ? Text(username) : Text(''),
              ),
              Divider(height: 0, color: Color(0x40121212)),
              ListTile(
                title: Text('Email'),
                subtitle: email != null ? Text(email) : Text(''),
              ),
              Divider(height: 0, color: Color(0x40121212)),
              ListTile(
                title: Text('Total Device'),
                subtitle: Consumer<Devices>(
                  builder: (context, devices, _) =>
                      Text('${devices.deviceCount}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
