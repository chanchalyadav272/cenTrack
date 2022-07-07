import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatabook_clone/user_model.dart';
import 'login_screen.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  userModel usermodel = userModel();

  @override
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.usermodel = userModel.fromMap(value.data());
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: (){
            logout(context);
          },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Welcome, ",
                style: TextStyle(
                  color: Colors.white
                ),),
                Text("${usermodel.username}",style: TextStyle(
                color: Colors.white,
                 fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
              ],
            )),
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person_outline_outlined))
        ],
      ),
    );
  }
  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: 'Logged out');
    print('logged out');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
