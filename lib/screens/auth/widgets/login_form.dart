import 'package:flutter/material.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/screens/widgets/buttons/primary_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObsecureText = true;
  bool _autovalidate = false;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: _autovalidate,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Email",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              isDense: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            validator: _validateEmail,
          ),
          SizedBox(height: 24),
          Text(
            "Password",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _isObsecureText,
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: InkResponse(
                radius: 16,
                child: Icon(
                  _isObsecureText ? Icons.visibility_off : Icons.visibility,
                  color: kPrimaryColor,
                ),
                onTap: () {
                  setState(() {
                    _isObsecureText = !_isObsecureText;
                  });
                },
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            validator: (val) => _validateRequired(val, 'Password'),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              onPress: () {
                if (_formKey.currentState.validate()) {
                  print("Submit");
                } else {
                  setState(() {
                    _autovalidate = true;
                  });
                }
              },
              text: "Login",
            ),
          )
        ],
      ),
    );
  }

  String _validateEmail(String value) {
    if (value == null || value == '') {
      return 'Email is required';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }

  String _validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName is required';
    }
    return null;
  }
}
