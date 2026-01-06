import 'package:flutter/material.dart';
import 'package:ot_news/ui/screens/sign_in_screen.dart';
import 'package:ot_news/ui/widgets/custom_text_field.dart';
import 'package:ot_news/ui/widgets/custom_text_field_password.dart';
import '../../logic/controllers/login_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final tfUserName = TextEditingController();
  final tfEmail = TextEditingController();
  final tfPassword = TextEditingController();
  final tfPasswordConfirm = TextEditingController();

  bool isLoading = false;

  final LoginController _loginController = LoginController();

  void handleSignUp() async {
    setState(() {
      isLoading = true;
    });

    await _loginController.signUp(
      context,
      tfUserName.text.trim(),
      tfEmail.text.trim(),
      tfPassword.text.trim(),
      tfPasswordConfirm.text.trim(),
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
                  "Create Your Account",
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

                                  CustomTextField(label: "Username", textEditingController: tfUserName, iconData: Icons.person),
                                  const SizedBox(height: 20),

                                  CustomTextField(label: "Email", textEditingController: tfEmail, iconData: Icons.email),
                                  const SizedBox(height: 20),

                                  CustomTextFieldPassword(label: "Password", textEditingController: tfPassword),
                                  const SizedBox(height: 20),

                                  CustomTextFieldPassword(label: "Confirm Password", textEditingController: tfPasswordConfirm),
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
                                      onPressed: isLoading ? null : handleSignUp,
                                      child: !isLoading
                                          ? const Text("SIGN UP", style: TextStyle(fontSize: 18))
                                          : const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(color: Colors.black),
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
                                            "Already have an account?",
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
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                                              }
                                            },
                                            child: const Text(
                                              "Sign In",
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