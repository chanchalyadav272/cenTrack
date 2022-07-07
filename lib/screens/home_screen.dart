import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value){
                  print('Signed Out');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                });
              },


              child: Text('Logout'))
        ],
      )
    );
  }
}
