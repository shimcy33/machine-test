import 'package:flutter/material.dart';
import 'package:machine_test/custom_libraries/custom_loader/RoundedLoader.dart';
import '../Utilities/login_model.dart';
import 'CustomColorCodes.dart';
import 'common_methods.dart';
import 'StringConstants.dart';

class CommonWidgets {

  showNetworkProcessingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Text(
                      "Loading..",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'roboto',
                      ),
                    ),
                  ),
                  RoundedLoader()
                ],
              ),
            ),
          );
        });
  }

  showNetworkErrorDialog(BuildContext context, msg) {
    CommonMethods().isInternetAvailable().then((onValue) {
      if (onValue) {
        showErrorDialog(context, msg);
      } else {
        String netFailure =
          StringConstants.netFailureMsg;
        showNetworkFailureDialog(context, netFailure);
      }
    });
  }

  void showErrorDialog(BuildContext context, msg) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          msg,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                      ],
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Close",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13.0),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          );
        });
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(13.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            fontFamily: 'roboto',
            color: textColor,
            fontSize: 16.0,
            fontWeight: FontWeight.normal),
      ),
    );
    return loginBtn;
  }

  void showNetworkFailureDialog(BuildContext context, String msg) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.white.withOpacity(0.98),
      // background color
      barrierDismissible: false,
      // should dialog be dismissed when tapped outside
      barrierLabel: "Dialog",
      // label for barrier
      transitionDuration: Duration(milliseconds: 400),
      // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return SizedBox.expand(
          // makes widget fullscreen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Image(
                image: AssetImage('assets/images/ic_404_error.png'),
                height: MediaQuery.of(context).size.height * .30,
                width: MediaQuery.of(context).size.width * .50,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                  10,
                  0,
                  10,
                  0,
                ),
                child: Text(
                  StringConstants.netFailureMsg,
                  style: new TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'roboto',
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 45,
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25)),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    30,
                    0,
                    30,
                    0,
                  ),
                  child: Text(
                   "Close",
                    style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget getErrorInfo(BuildContext context, String message) {
    if (LoginModel().isNetworkAvailable) {
      return Container(
        alignment: FractionalOffset.center,
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'roboto',
          ),
        ),
      );
    } else {
      return Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/no_internet.png'),
                height: MediaQuery.of(context).size.height * .30,
                width: MediaQuery.of(context).size.width * .50,
              ),
              Container(
                alignment: FractionalOffset.center,
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text(
                  "${StringConstants.netFailureMsg}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'roboto',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
  }
}
