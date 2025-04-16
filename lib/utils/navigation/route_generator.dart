import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_lab/features/authentication/signup.dart';
import 'package:food_app_lab/features/onboarding/onborading_01.dart';

import '../../features/authentication/login.dart';
import '../../features/cart/Cart.dart';
import '../../features/cart/cubit/cart_meal_cubit.dart';
import '../../features/details/cubits/details_cubit.dart';
import '../../features/home/cubits/category_cubit.dart';
import '../../features/home/cubits/special_offer_cubit.dart';
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
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LogIn());
      case AppRoutes.details:
       // return MaterialPageRoute(builder: (_) => Details());
      case AppRoutes.home:
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<CategoryCubit>(
              create: (context) => CategoryCubit()..getCategories(),
            ),
            BlocProvider<SpecialOfferCubit>(
              create: (context) => SpecialOfferCubit()..getMealsByCategory("Beef"),
            ),
          ],
          child: const Home(),
        ),
      );

      case AppRoutes.cart:
        final args = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => BlocProvider(
  create: (context) => CartMealCubit()..getMeals(args),
  child: Cart(user: args),
));
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}