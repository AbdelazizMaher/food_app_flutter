import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app_lab/features/authentication/widgets/AuthConfirmation.dart';
import 'package:food_app_lab/features/authentication/widgets/AuthHeader.dart';

import '../../utils/navigation/app_routes.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name = '';
  String _email = '';
  String _password = '';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  void _saveUserData() async {
    if (_name.isEmpty || _email.isEmpty || _password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (!_email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')));
      return;
    }

    await _storage.write(key: 'name', value: _name);
    await _storage.write(key: 'email', value: _email);
    await _storage.write(key: 'password', value: _password);
    await _storage.write(key: 'isLoggedIn', value: 'true');

    Navigator.pushNamed(context, AppRoutes.home);
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.home);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AuthHeader(
            imagePath: "assets/images/signup_bg.png",
            title: "Sign Up",
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
                        "Full Name",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    TextField(
                      onChanged: (value) => _name = value,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        filled: true,
                        fillColor: Color(0xFFF9F9FA),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFF9F9FA)),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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

                    AuthConfirmation(
                      buttonText: "Sign Up",
                      option: "Or Sign Up with",
                      onButtonPressed: () {
                         _saveUserData();
                      },
                      onGooglePressed: () => (){},
                      onFacebookPressed: () {},
                      bottomText: "Already have an account? ",
                      actionText: "Login",
                      onActionTap: () => _navigateToLogin(context),
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

