import 'package:flutter/material.dart';
import 'package:ot_news/ui/screens/sign_up_screen.dart';
import 'main_screen.dart';

import '../../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});



  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();

  final AuthService authService = AuthService();
  void signIn() async{
    final email = tfEmail.text.trim();
    final password = tfPassword.text.trim();

    setState(() {
      isLoading = true;
    });

    final user = await authService.signIn(email, password);
    if(!mounted) return;

    if(user != null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()),(route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Login Successful"),backgroundColor: Colors.green,));
    }
    else{
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Login Failed, check your email/password")));
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
                                  TextField(
                                    controller: tfEmail,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: const Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Password
                                  TextField(
                                    controller: tfPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: const Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),

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
                                      onPressed: isLoading ? null : signIn,
                                      child: !isLoading ? const Text("SIGN IN",
                                          style: TextStyle(fontSize: 18)) : const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(color: Colors.black,strokeWidth: 3,),
                                      ) ,
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
                                              !isLoading ? Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen())) : null;
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