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
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Customers',),
              Tab(text: 'Suppliers',),
            ],

          ),
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
            IconButton(onPressed: (){}, icon: Icon(Icons.person_outline_outlined)),

          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined),
            label: 'Parties'),
            BottomNavigationBarItem(icon: Icon(Icons.currency_rupee_outlined),
            label: 'Money'),
            BottomNavigationBarItem(icon: Icon(Icons.category_outlined),label: 'More')
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushNamed(context, '/addnew');
          },
          backgroundColor: Colors.pink.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))
          ),
          // child: Row(
          //   children: [
          //     Icon(Icons.person_add),
          //     Text('ADD CUSTOMER')
          //   ],
          // ),
          label: Row(

            children: [
              Icon(Icons.person_add),
              SizedBox(width:15,),
              Text('ADD CUSTOMER')
            ],

          ),
        ),

        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
              ),
              ),
            Container(
              height: 73,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),

           SingleChildScrollView(


              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Material(
                      elevation: 10,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(

                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        height: 130,
                        width: double.infinity,

                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IntrinsicHeight(

                              child: Row(
                                children: [
                                  Expanded(child: Container(
                                    child: Column(

                                      children: [

                                        Text('₹ 47',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24
                                        ),),

                                      Text('You will give',
                                      style: TextStyle(
                                        color: Colors.grey
                                      ),),

                                    ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    ),
                                  )),
                                  VerticalDivider(width: 16,
                                  color: Colors.black38,),
                                  Expanded(child: Container(
                                    child: Column(

                                      children: [

                                        Text('₹ 1',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24
                                          ),),

                                        Text('You will get',
                                          style: TextStyle(
                                              color: Colors.grey
                                          ),),

                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    ),
                                  )),

                                ],
                              ),
                            ),
                            Divider(height: 16,
                            color: Colors.black38,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('VIEW REPORT ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18
                                    ,fontWeight: FontWeight.bold,
                                ),),
                                Icon(Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Colors.blue,
                                )
                              ],
                            )
                          ],
                        ),

                      ),
                    ),
                  )
                ],

              ),
            ),

    ],
        ),








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
