import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khatabook_clone/screens/home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool loading =false;
  String errorMessage = "";
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
                          Container(
                            height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white70
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
                                  controller: _emailcontroller,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value == null || value.isEmpty){
                                      return 'Please enter email address';
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
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  else if (value.length < 8){
                                    return "Password must be at least 8 characters";
                                  }
                                  else{
                                    return null;
                                  }

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
                                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text).then((value){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                                      print("Signed In");
                                    }).onError((error, stackTrace){
                                        print('Error ${error.toString()}');
                                    });


                                    // Navigator.pushNamed(context, '/home');
                                  },
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









                    ],
                  ),
                  ),
                ],
              ),
            ),


    );
  }
}
