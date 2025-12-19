import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ot_news/ui/screens/main_screen.dart';
import 'package:ot_news/ui/screens/sign_in_screen.dart';
import 'package:ot_news/ui/screens/sign_up_screen.dart';

import '../../services/auth_service.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});





  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    void signInWithGoogle() async{
      final user = await authService.signInWithGoogle();


      if(user != null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Sign In With Google Successful"),backgroundColor: Colors.green));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()),(route) => false);
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Sign In With Google Failed"),));
      }
    }




    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(height: 100),

                  const Icon(FontAwesomeIcons.newspaper, size: 80, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    "One Tap News",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),


                  const SizedBox(height: 60),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 60),

                  SizedBox(
                    width: width * 0.85,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white, width: 2),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                      },
                      child: const Text("SIGN IN", style: TextStyle(fontSize: 18)),
                    ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: width * 0.85,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF381E3C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: const Text("SIGN UP", style: TextStyle(fontSize: 18)),
                    ),
                  ),

                  const SizedBox(height: 120),

                  const Text(
                    "Login with Social Media",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      IconButton(onPressed: signInWithGoogle, icon: const Icon(FontAwesomeIcons.google,color: Colors.white,size: 32)),
                      IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.xTwitter,color: Colors.white,size: 32)),
                      IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.instagram,color: Colors.white,size: 32)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
