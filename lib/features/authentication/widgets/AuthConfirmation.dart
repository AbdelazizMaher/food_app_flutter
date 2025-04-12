import 'package:flutter/material.dart';

class AuthConfirmation extends StatelessWidget {
  final String buttonText;
  final VoidCallback onButtonPressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;
  final String bottomText;
  final String actionText;
  final VoidCallback onActionTap;

  const AuthConfirmation({
    super.key,
    required this.buttonText,
    required this.onButtonPressed,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    required this.bottomText,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: SizedBox(
            width: 260,
            height: 60,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Or Sign up with",
          style: TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: Image.asset("assets/images/facebook.png", height: 40),
                label: const Text("Facebook"),
                onPressed: onFacebookPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 20,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                icon: Image.asset("assets/images/google.png", height: 40),
                label: const Text("Google"),
                onPressed: onGooglePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 20,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(bottomText),
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
