import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utilities/login_model.dart';
import 'StringConstants.dart';

class CommonMethods {
  String getNetworkError(error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = StringConstants.dioErrorTypeCancel;
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = StringConstants.dioErrorTypeConnectTimeout;
          break;
        case DioErrorType.DEFAULT:
          errorDescription = StringConstants.dioErrorTypeDefault;
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = StringConstants.dioErrorTypeReceiveTimeout;
          break;
        case DioErrorType.RESPONSE:
          errorDescription = StringConstants.dioErrorTypeResponse;
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = StringConstants.dioErrorTypeSendTimeout;
          break;
      }
    } else {
      errorDescription = StringConstants.normalErrorMessage;
    }

    return errorDescription;
  }

  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// My way of capitalizing each word in a string.
  String titleCase(String text) {
    if (text == null) return "";

    if (text.isEmpty) return text;

    /// If you are careful you could use only this part of the code as shown in the second option.
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  checkNetworkConnection() {
    CommonMethods().isInternetAvailable().then((onValue) {
      if (!onValue) {
        LoginModel().isNetworkAvailable = false;
        BuildContext con = LoginModel().currentContext;
        if (con != null) {
          Flushbar(
            backgroundColor: Colors.white,
            messageText: Text(
              StringConstants.netFailureMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'roboto',
                  color: Colors.black),
            ),
            icon: Image(
              image: AssetImage('assets/images/no_internet.png'),
              height: 30,
              width: 30,
            ),
            duration: Duration(seconds: 2),
            leftBarIndicatorColor: Colors.red,
          )..show(con);
        } else {
          Fluttertoast.showToast(
              msg: "${StringConstants.netFailureMsg}",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        LoginModel().isNetworkAvailable = true;
      }
    });
  }
}
