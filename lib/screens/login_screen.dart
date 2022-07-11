import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khatabook_clone/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = new TextEditingController();
  final passwordcontroller = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  Stream<User?> get authChange => _auth.authStateChanges();




  bool loading =false;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Tally Sheet',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 32
        ),),
        elevation: 0,
      ),
        body: loading ?
            Center(
              child: SpinKitChasingDots(
                color: Colors.black,
                size: 50,
              ),
            )
       : Container(
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
                              height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white70
                            ),


                            ),
                          ),
                        ],
                      ),

                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget>  [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height:75,),
                          Text("Welcome Back",
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
                                      hintText: 'Email',
                                      alignLabelWithHint: true,
                                      prefixIcon: Icon(Icons.email_outlined,
                                      size: 24,
                                      color: Colors.black38,),
                                      hintStyle: TextStyle(
                                        fontSize: 16
                                      )
                                    ),
                                    controller: emailcontroller,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    onSaved: (value){
                                      emailcontroller.text = value!;
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
                                  controller: passwordcontroller,
                                  keyboardType: TextInputType.text,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                    passwordcontroller.text = value!;
                                  },
                                  obscureText: true,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.all(Radius.circular(10))

                                ),
                              ),
                              SizedBox(height: 4,),
                              SizedBox(
                                height: 16,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      child: Text('Forgot password?',
                                      style: TextStyle(
                                        color: Colors.redAccent
                                      ),),
                                      onTap: (){
                                        print('forgot password');
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 40,),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                    onPressed: (){
                                      signIn(emailcontroller.text, passwordcontroller.text);
                                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                        print("Signed In");
                                      },


                                      // Navigator.pushNamed(context, '/home');

                                    style: ButtonStyle(

                                    ),
                                    child: Text("Sign In",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),)),
                              ),
                              SizedBox(height: 40,),
                              SizedBox(
                                height: 16,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account?  ",
                                    style: TextStyle(
                                      color: Colors.black54
                                    ),),
                                    GestureDetector(
                                      child: Text('Create an account',
                                        style: TextStyle(
                                          color: Colors.blueAccent
                                        ),
                                      ),
                                      onTap: (){
                                        print('create a new account');
                                        Navigator.pushReplacementNamed(context, '/signup');
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
                  ),
                ],
              ),
            ),


    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home())),
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
}

