import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthButtons extends StatelessWidget {
  final VoidCallback onSignUp;
  final VoidCallback onLogin;

  const AuthButtons({
    super.key,
    required this.onSignUp,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: onSignUp,
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.only(left: 52, right: 52, top: 18, bottom: 18),
                side: const BorderSide(color: Colors.white, width: 2.0),
              ),
              child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18))
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: onLogin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 52, right: 52, top: 18, bottom: 18),
                backgroundColor: Colors.black,
              ),
              child: const Text("Log In", style: TextStyle(color: Colors.white, fontSize: 18))
            ),
          ],
        ),
      ),
    );
  }
}

