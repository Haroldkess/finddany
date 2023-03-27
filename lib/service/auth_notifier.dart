

import 'package:flutter/widgets.dart';

import '../models/user_model.dart';


class AuthNotifier with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
