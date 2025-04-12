import 'package:flutter/material.dart';

import '../../utils/navigation/app_routes.dart';
import 'widgets/AuthButtons.dart';
import '../authentication/signup.dart';


class OnBoarding01 extends StatelessWidget {
  const OnBoarding01({super.key});

  void _navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color(0xFFFF6B57),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                "assets/images/onboarding_pizza.png",
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                "assets/images/onboarding_bg.png",
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child : Padding(
                  padding: const EdgeInsets.only(top: 200.0, left: 20.0, right: 40.0),
                  child: Text("I don't feel like cooking. Let's order food delivery.", textAlign: TextAlign.start, style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold))
              )
            ),
            AuthButtons(
              onSignUp: () => _navigateToSignUp(context),
              onLogin: () => (){},
            ),
          ]
        )
    );
  }
}
