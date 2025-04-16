import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../utils/navigation/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      storage.read(key: 'isLoggedIn').then((value) {
        if (value == 'true') {
          Navigator.pushNamed(context, AppRoutes.home);
        } else {
            Navigator.pushNamed(context, AppRoutes.onBoarding01);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Container(
                color: Color(0xFFFF6B57)
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Image.asset("assets/images/splash_up.png")
            ),
            Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/splash_main.png"),
                      Text("Comida", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold))
                    ]
                )
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset("assets/images/splash_down.png")
            ),
          ]
      )
    );
  }
}
