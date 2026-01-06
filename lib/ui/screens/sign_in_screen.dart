import 'package:flutter/material.dart';
import 'package:ot_news/ui/screens/sign_up_screen.dart';
import 'package:ot_news/ui/widgets/custom_text_field.dart';
import 'package:ot_news/ui/widgets/custom_text_field_password.dart';
import '../../logic/controllers/login_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;

  final tfEmail = TextEditingController();
  final tfPassword = TextEditingController();

  final LoginController _loginController = LoginController();

  void handleSignIn() async {
    setState(() {
      isLoading = true;
    });

    await _loginController.signIn(
        context,
        tfEmail.text.trim(),
        tfPassword.text.trim()
    );

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFEB4A7B),
                Color(0xFF5A2E98),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.only(left: 36),
                child: Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 36),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 80),

                                  // Email
                                  CustomTextField(label: "Email", textEditingController: tfEmail, iconData: Icons.email),

                                  const SizedBox(height: 20),

                                  // Password
                                  CustomTextFieldPassword(label: "Password", textEditingController: tfPassword),

                                  const SizedBox(height: 80),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 55,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF381E3C),
                                        foregroundColor: const Color(0xFFFFFFFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      onPressed: isLoading ? null : handleSignIn,
                                      child: !isLoading
                                          ? const Text("SIGN IN", style: TextStyle(fontSize: 18))
                                          : const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(color: Colors.black, strokeWidth: 3),
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 40.0),
                                    child: Column(
                                      children: [
                                        const Center(
                                          child: Text(
                                            "Don't have an account?",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Center(
                                          child: TextButton(
                                            onPressed: () {
                                              if (!isLoading) {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                                              }
                                            },
                                            child: const Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  color: Color(0xFFB53C52),
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}