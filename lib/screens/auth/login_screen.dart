import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensor_app/screens/auth/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 88),
              Container(
                child: SvgPicture.asset("assets/images/plant.svg",
                    width: MediaQuery.of(context).size.height / 5),
              ),
              SizedBox(height: 32),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
