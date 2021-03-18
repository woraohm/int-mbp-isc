import 'package:corperate_banking/screens/index_screen.dart';
import 'package:corperate_banking/screens/screen_auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds:LoginScreen(),
      image: Image.asset('assests/images/logo_isc_medium_purple.png'),
      photoSize: 150,
  
      loaderColor: Colors.purpleAccent,
      //backgroundColor: Colors.black,

    );
  }
}