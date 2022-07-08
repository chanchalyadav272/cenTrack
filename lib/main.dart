import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khatabook_clone/screens/addnew_page.dart';
import 'package:khatabook_clone/screens/home_screen.dart';
import 'package:khatabook_clone/screens/signup_screen.dart';
import 'package:khatabook_clone/screens/transactions_page.dart';

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
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home(),
        // '/transactions': (context) => Transactions(),
        '/addnew' : (context) => AddNew(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authChange,
        builder: (context, snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: SpinKitChasingDots(
                color: Colors.black,
                size: 50,
              ),
            );
          }
          if(snapshot.hasData){
            return const Home();
          }
          return const Login();
        },
      ),

    );
  }
}

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authChange => _auth.authStateChanges();
}


