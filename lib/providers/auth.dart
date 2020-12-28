import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  String _email = '';

  String get email {
    return _email;
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }
}
