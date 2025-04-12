import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/navigation/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _navigate(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.onBoarding01);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigate(context),
      child: Scaffold(
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
      )
    );
  }
}
