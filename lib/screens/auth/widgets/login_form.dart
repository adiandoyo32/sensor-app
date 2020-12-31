import 'package:flutter/material.dart';
import 'package:sensor_app/base_screen.dart';
import 'package:sensor_app/constants/colors.dart';
import 'package:sensor_app/screens/widgets/buttons/primary_button.dart';
import 'package:sensor_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isLoading = false;
  bool _isObsecureText = true;
  bool _autovalidate = false;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  _showMsg(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'orange@email.com');
    _passwordController = TextEditingController(text: '1234orange1234');
  }

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
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    onPress: () {
                      if (_formKey.currentState.validate()) {
                        _login();
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var res = await AuthService()
        .authData(_emailController.text, _passwordController.text);

    if (res.containsKey("access_token")) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", res["access_token"]);
      localStorage.setString("email", _emailController.text);
      var userData = await AuthService().getUserData(_emailController.text);
      localStorage.setString("userId", userData['id'].toString());
      localStorage.setString("username", userData['name']);
      localStorage.setString("role", userData['roles'][0]['name']);
      Navigator.pushReplacementNamed(
        context,
        BaseScreen.routeName,
      );
    } else {
      _showMsg("Wrong email or password!");
    }

    setState(() {
      _isLoading = false;
    });
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
