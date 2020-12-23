import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "profile_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
                      image: NetworkImage(
                          "https://reqres.in/img/faces/7-image.jpg"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Name'),
                subtitle: Text("User"),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text("name@email.com"),
              ),
              ListTile(
                title: Text('Device'),
                trailing: Text("1"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
