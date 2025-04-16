

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app_lab/features/authentication/widgets/AuthConfirmation.dart';
import 'package:food_app_lab/features/authentication/widgets/AuthHeader.dart';

import '../../utils/navigation/app_routes.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String _email = '';
  String _password = '';

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.home);
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  FlutterSecureStorage storage = const FlutterSecureStorage();
  void _authenticateUserData() async {
    final email = await storage.read(key: 'email');
    print(email);
    final password = await storage.read(key: 'password');
    print(password);
    if (email == _email && password == _password) {
      await storage.write(key: 'isLoggedIn', value: 'true');
      _navigateToHome(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AuthHeader(
            imagePath: "assets/images/signup_bg.png",
            title: "Log In",
            subtitle: "Please sign up to get started",
            onBack: Navigator.of(context).pop,
          ),

          Positioned(
            top: 250,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "E-Mail",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    TextField(
                      onChanged: (value) => _email = value,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        filled: true,
                        fillColor: Color(0xFFF5F6FA),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Password",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    TextField(
                      onChanged: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off),
                        filled: true,
                        fillColor: const Color(0xFFF5F6FA),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Forgot Password?", style: TextStyle(color: Colors.redAccent))
                    ),
                    const SizedBox(height: 25),
                    AuthConfirmation(
                      buttonText: "Log In",
                      option: "Or logIn with",
                      onButtonPressed: () => {
                        _authenticateUserData()
                      },

                      onGooglePressed: () => (){},
                      onFacebookPressed: () => (){},
                      bottomText: "Don't have an account? ",
                      actionText: "SignUp",
                      onActionTap: () => _navigateToSignUp(context),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
