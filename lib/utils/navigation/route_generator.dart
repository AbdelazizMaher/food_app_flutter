import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_lab/features/authentication/signup.dart';
import 'package:food_app_lab/features/onboarding/onborading_01.dart';

import '../../features/cart/Cart.dart';
import '../../features/details/details.dart';
import '../../features/home/home.dart';
import '../../features/splash/splash_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.onBoarding01:
        return MaterialPageRoute(builder: (_) => OnBoarding01());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => SignUp());
      case AppRoutes.details:
       // return MaterialPageRoute(builder: (_) => Details());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => Home());
      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => Cart());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}