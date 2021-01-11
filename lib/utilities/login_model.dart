import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:machine_test/models/employee_list_model.dart';

class LoginModel {
  static final LoginModel _singleton = LoginModel._internal();

  factory LoginModel() => _singleton;

  LoginModel._internal(); // private constructor
  BuildContext currentContext;
  bool isNetworkAvailable = true;
  final GlobalKey<NavigatorState> appNavigatorKey =
      new GlobalKey<NavigatorState>();

  List<EmployeeListModel> offlineList = new List();


  void clearInfo() {

  }
}
