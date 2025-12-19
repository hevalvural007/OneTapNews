import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var tfUserName = TextEditingController();
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();
  var tfPasswordConfirm = TextEditingController();

  bool isLoading = false;

  final AuthService authService = AuthService();

  void signUp() async{
    final email = tfEmail.text.trim();
    final password = tfPassword.text.trim();
    final username = tfUserName.text.trim();
    final confirmPassword = tfPasswordConfirm.text.trim();

    setState(() {
      isLoading = true;
    });


    if(password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Passwords do not match")));
      setState(() {
        isLoading = false;
      });
      return;
    }
    if(email.isEmpty || username.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Please Fill Every Input in the Form")));
      setState(() {
        isLoading = false;
      });
      return;
    }
    final user = await authService.signUp(email, password, username);
    if(!mounted) return;
    if(user!=null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Account created! Pleaser Login"),backgroundColor: Colors.green));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()),(route) => false);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("An error occurred while creating the account, please try again")));
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

                                  TextField(
                                    controller: tfUserName,
                                    decoration: InputDecoration(
                                      labelText: "Username",
                                      prefixIcon: const Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),


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

                                  const SizedBox(height: 20),

                                  // Confirm Password
                                  TextField(
                                    controller: tfPasswordConfirm,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: "Confirm Password",
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
                                      onPressed: isLoading ? null : signUp,
                                      child: !isLoading ? const Text("SIGN UP",
                                          style: TextStyle(fontSize: 18)) : const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(color: Colors.black,),
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
                                              !isLoading ? Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen())) : null;
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
