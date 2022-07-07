import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khatabook_clone/screens/home_screen.dart';
import 'package:khatabook_clone/screens/signup_screen.dart';

import 'screens/login_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home()
      },
      home: Login(),

    );
  }
}
