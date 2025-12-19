import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ot_news/firebase_options.dart';
import 'package:ot_news/ui/screens/home_screen.dart';
import 'package:ot_news/ui/screens/login_screen.dart';
import 'package:ot_news/ui/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Api Key: ${const String.fromEnvironment('API_KEY')}");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen()

    );
  }
}

