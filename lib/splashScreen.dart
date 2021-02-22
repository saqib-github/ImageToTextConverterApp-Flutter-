import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'homePage.dart';


class MySplashScreen extends StatefulWidget {
  MySplashScreen({Key key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

// ignore: camel_case_types
class _splashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: HomePage(),
      title: Text(
        "Image to Text Converter",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      image: Image.asset('assets/imagetext.png'),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        'From Saqib Tech',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
