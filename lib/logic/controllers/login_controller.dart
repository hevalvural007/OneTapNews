import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../ui/screens/main_screen.dart';
import '../../ui/screens/sign_in_screen.dart';

class LoginController {
  final AuthService _authService = AuthService();

  void _showSnack(BuildContext context, String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  Future<void> signIn(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showSnack(context, "Please fill all fields");
      return;
    }

    final user = await _authService.signIn(email, password);

    if (!context.mounted) return;

    if (user != null) {
      _showSnack(context, "Login Successful", color: Colors.green);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
      );
    } else {
      _showSnack(context, "Login Failed, check your email/password");
    }
  }

  Future<void> signUp(BuildContext context, String username, String email, String password, String confirmPassword) async {
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      _showSnack(context, "Please Fill Every Input in the Form");
      return;
    }

    if (password != confirmPassword) {
      _showSnack(context, "Passwords do not match");
      return;
    }

    final user = await _authService.signUp(email, password, username);

    if (!context.mounted) return;

    if (user != null) {
      _showSnack(context, "Account created! Please Login", color: Colors.green);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
      );
    } else {
      _showSnack(context, "An error occurred while creating the account");
    }
  }
}