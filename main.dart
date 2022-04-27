import 'package:flutter/material.dart';
import 'package:hydroponics/screens/home_screen.dart';
import 'package:hydroponics/screens/login_Screen.dart';
import 'package:hydroponics/screens/registration_screen.dart';
import 'package:hydroponics/screens/error_screen.dart';
import 'package:hydroponics/screens/splash_screen.dart';
import 'package:hydroponics/services/init.dart';

void main() {
  runApp(HydroponicApp());
}

class HydroponicApp extends StatelessWidget {
  final Future _initFuture = Init.initialize();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<dynamic>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data == 'logged_in') {
                return Home_Screen();
              } else {
                return LoginScreen();
              }
            } else {
              //TODO error_screen
              return Error();
            }
          } else {
            return SplashScreen();
          }
        },
      ),
      routes: {
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        Home_Screen.id: (context) => Home_Screen(),
        Error.id: (context) => Error(),
      },
    );
  }
}



