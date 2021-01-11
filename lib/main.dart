import 'package:flutter/material.dart';
import 'package:machine_test/screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MachineTest());
}

class MachineTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
            seconds: 2,
            navigateAfterSeconds: new HomeScreen(),
            title: new Text('Loading'),
            loaderColor: Colors.red));
  }
}
