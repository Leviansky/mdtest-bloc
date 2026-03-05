import 'package:flutter/material.dart';
import 'package:mdtestapp/widgets/global/button.dart';

class ReAuthActions extends StatelessWidget {
  final VoidCallback onRegister;
  final VoidCallback onForgotPassword;

  const ReAuthActions({
    super.key,
    required this.onRegister,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GTextAction(label: "Register", onPressed: onRegister),
            const SizedBox(width: 8),
            Container(width: 1, height: 14, color: const Color(0xFFE6ECFF)),
            const SizedBox(width: 8),
            GTextAction(
              label: "Forgot Password",
              onPressed: onForgotPassword,
              color: const Color(0xFF4B5563),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          "By continuing, you agree to our terms & privacy policy.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF6B7280), fontSize: 12, height: 1.3),
        ),
      ],
    );
  }
}
