import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khatabook_clone/resources/registeredList.dart';
import 'package:khatabook_clone/resources/lib.dart';
import 'package:khatabook_clone/screens/transactions_page.dart';
import 'package:khatabook_clone/user_model.dart';
import 'login_screen.dart';
import 'package:flutter/src/rendering/box.dart';




class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  userModel usermodel = userModel();
  int _currentIndex =0;




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
      pageState.refreshTransactionsForCurrentUser();


    });
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade700,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4,
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
            IconButton(onPressed: (){
              print(FirebaseAuth.instance.currentUser?.displayName);

            }, icon: Icon(Icons.person_outline_outlined)),

          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          currentIndex: _currentIndex,
          onTap: (value){
            _currentIndex = value;
            setState((){});
          },

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
                color: Colors.blueAccent.shade700,
              ),
            ),

           SingleChildScrollView(


              child: Column(
                // mainAxisSize: MainAxisSize.max,
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
                                GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('VIEW REPORT ',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18
                                      ,fontWeight: FontWeight.bold,
                                  ),),
                                ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric( vertical: 8),
                    child: Material(
                      // borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(

                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        // height: 130,
                        width: double.infinity,

                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IntrinsicHeight(

                              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                 Padding(
                                   padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                   child: Container(


                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       border: Border.all(color: Colors.grey),
                                       borderRadius: BorderRadius.all(Radius.circular(10))
                                     ),
                                     height: 40,
                                     width: MediaQuery.of(context).size.width*0.7,
                                     child: TextFormField(

                                       decoration: InputDecoration(

                                         prefixIcon: Icon(Icons.search),
                                         hintText: 'Search Customer',
                                           hintStyle: TextStyle(
                                               color: Colors.grey
                                           ),
                                         border: InputBorder.none

                                       ),
                                     ),

                                   ),

                                 ),
                                  Icon(Icons.filter_alt_outlined,
                                  color: Colors.blue,
                                  size: 30,),
                                  Icon(Icons.picture_as_pdf_outlined,
                                  size: 28,
                                  color: Colors.blue,)

                                ],
                              ),
                            ),
                            Divider(height: 16,
                              color: Colors.black38,),

                            Container(

                              height: MediaQuery.of(context).size.height*0.5,
                              child: CustomScrollView(
                                slivers: [
                                  SliverList(
                                    delegate: SliverChildListDelegate(
                                        pageState.transactions.values.toList().map((data){
                                          return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Transactions(customerUid: data['customerUid'], customerName: data['customerName'], transactionPageId: data['transactionPageId'])));

                                                  },
                                                  child: ListTile(
                                                    title:  Text(data['customerName'].toString(),),
                                                    subtitle: (int.parse(data['balance'].toString()))>=0 ? null :
                                                    Row(
                                                      children: [
                                                        Icon(Icons.alarm, size: 18,),
                                                        Text(' Set due date')
                                                      ],
                                                    ),
                                                    leading: CircleAvatar(
                                                      backgroundColor: Colors.black12,
                                                      child: Text('${data['customerName'].toString()[0].toUpperCase()}',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                    ),
                                                    trailing: Text('₹ ${(int.parse(data['balance'].toString())).abs()}',
                                                      style: TextStyle(
                                                          color: (int.parse(data['balance'].toString()))>=0 ? Colors.green : Colors.red
                                                      ),),
                                                  ),
                                                ),
                                              ),
                                              Divider(height: 4,)
                                            ],
                                          );
                                        }).toList()
                                    ),
                                  ),
                                ],
                              )),
                            Container(
                              color: Colors.white,
                              height:MediaQuery.of(context).size.height,
                            )


                          ],
                        ),

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
  Future<void> logout(BuildContext context) async
  {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: 'Logged out');
    print('logged out');
    Navigator.pushReplacementNamed(context, '/login');
  }





}

class People extends StatelessWidget {
  const People({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
