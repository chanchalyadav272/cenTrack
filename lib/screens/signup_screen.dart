import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatabook_clone/user_model.dart';
import 'home_screen.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _usernamecontroller = TextEditingController();
  final _dobcontroller = TextEditingController();
  String? errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Khatabook',

          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32
          ),),
        elevation: 0,
      ),
      body:
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/khatabookBackground0.jpg'),
                fit: BoxFit.fill
            )

        ),
        child: Stack(
          fit: StackFit.expand,
          children:<Widget> [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                   Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Container(

                        height: 500,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white70
                        ),


                      
                    ),
                  ),
                  
                  // Expanded(flex: 2,child: Container())
                ],
              ),

            ),
            SingleChildScrollView(child:
            Padding(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>  [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height:75,),
                      Text("Create a new account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold

                        ),),
                    ],
                  ),


                  Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [

                          Container(

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: new InputDecoration(
                                    hintText: 'Username',
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(Icons.person_outline_outlined,
                                      size: 24,
                                      color: Colors.black38,),
                                    hintStyle: TextStyle(
                                        fontSize: 16
                                    )
                                ),
                                controller: _usernamecontroller,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty){
                                    return 'Username cannot be empty';
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),
                            ),
                            // color: Colors.white70,

                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(Radius.circular(10))

                            ),
                          ),
                          SizedBox(height: 8,),
                          Container(

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: new InputDecoration(
                                    hintText: 'Date of Birth (dd-mm-yyyy)',
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(Icons.date_range_outlined,
                                      size: 24,
                                      color: Colors.black38,),
                                    hintStyle: TextStyle(
                                        fontSize: 16
                                    )
                                ),
                                controller: _dobcontroller,
                                keyboardType: TextInputType.datetime,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.isEmpty){
                                    return 'Please enter a valid D.O.B.';
                                  }
                                  else{
                                    return null;
                                  }
                                },
                              ),
                            ),
                            // color: Colors.white70,

                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(Radius.circular(10))

                            ),
                          ),
                          SizedBox(height: 8,),

                          Container(

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: new InputDecoration(
                                    hintText: 'Email',
                                    alignLabelWithHint: true,
                                    prefixIcon: Icon(Icons.email_outlined,
                                      size: 24,
                                      color: Colors.black38,),
                                    hintStyle: TextStyle(
                                        fontSize: 16
                                    )
                                ),
                                controller: _emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                onSaved: (value){
                                  _emailcontroller.text = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter your email");
                                  }
                                  // reg expression for email validation
                                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(value)) {
                                    return ("Please Enter a valid email");
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // color: Colors.white70,

                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(Radius.circular(10))

                            ),
                          ),
                          SizedBox(height: 8,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: new InputDecoration(
                                  hintText: 'Password',
                                  alignLabelWithHint: true,
                                  prefixIcon: Icon(Icons.lock,
                                    size: 24,
                                    color: Colors.black38,),
                                  hintStyle: TextStyle(
                                      fontSize: 16
                                  )
                              ),
                              controller: _passwordcontroller,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                              },
                              onSaved: (value) {
                                _passwordcontroller.text = value!;
                              },
                              obscureText: true,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(Radius.circular(10))

                            ),
                          ),
                          SizedBox(height: 4,),


                          SizedBox(height: 4,),
                          // SizedBox(
                          //   height: 16,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       GestureDetector(
                          //         child: Text('Forgot password?',
                          //           style: TextStyle(
                          //               color: Colors.redAccent
                          //           ),),
                          //         onTap: (){
                          //           print('forgot password');
                          //         },
                          //       )
                          //     ],
                          //   ),
                          // ),
                          SizedBox(height: 10,),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                                onPressed: () {

                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));

                                signUp(_emailcontroller.text, _passwordcontroller.text);


                                  print("Sign up");
                                },
                                style: ButtonStyle(

                                ),
                                child: Text("Sign Up",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),)),
                          ),
                          SizedBox(height: 15,),
                          SizedBox(
                            height: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Already have an account?  ",
                                  style: TextStyle(
                                      color: Colors.black54
                                  ),),
                                GestureDetector(
                                  child: Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.blueAccent
                                    ),
                                  ),
                                  onTap: (){
                                    print('sign in');
                                    Navigator.pushReplacementNamed(context, '/login');
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),









                ],
              ),
            ),),
          ],
        ),
      ),


    );

  }
  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;

  userModel usermodel = userModel();

  usermodel.email = user!.email;
  usermodel.uid = user!.uid;
  usermodel.username = _usernamecontroller.text;
  usermodel.dob = _dobcontroller.text;


  await firebaseFirestore.collection('users').doc(user.uid).set(usermodel.toMap());
  Fluttertoast.showToast(msg: "Account created successfully :) ");

Navigator.restorablePushNamedAndRemoveUntil(context, '/home',
        (route) => false);





  }



}




