import 'dart:ffi';

import 'package:azlistview/azlistview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khatabook_clone/resources/registeredData.dart';
import 'package:khatabook_clone/screens/transactions_page.dart';



class RegisteredList extends StatefulWidget {
  const RegisteredList({Key? key}) : super(key: key);

  @override
  State<RegisteredList> createState() => _RegisteredListState();
}

class _RegisteredListState extends State<RegisteredList> {
  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference transactionPages = FirebaseFirestore.instance.collection('transactionPages');
  var  customerUid;
  var  customerName;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var transactionPageId;


  void callTransactionsPage (BuildContext context, String name, String uid) async{
    customerUid = uid;
    customerName = name;

    await transactionPages.where('users', isEqualTo: {customerUid: null, currentUserId:null}).limit(1).get()
          .then((QuerySnapshot querySnapshot)
      {
        if(querySnapshot.docs.isNotEmpty){
          transactionPageId =  querySnapshot.docs.single.id;


        }
        else(
            transactionPages.add({
              'users': {
                currentUserId: null,
                customerUid:null,

              }
            }).then((value) => {
              transactionPageId = value
            })
        );




      }).catchError((error){});

    Navigator.push(
        (context), MaterialPageRoute(builder: (context) => Transactions(customerUid: uid, customerName: name, transactionPageId: transactionPageId,))
    );

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').where('uid', isNotEqualTo: currentUser).snapshots(),
      builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError){
          return Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: SpinKitChasingDots(
              color: Colors.black,
              size: 50,
            ),
          );
        }
        if(snapshot.hasData){
          return Container(

            child: CustomScrollView(
              slivers: [
                SliverList(delegate: SliverChildListDelegate(snapshot.data!.docs.map((DocumentSnapshot document){
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return ListTile(
                    onTap: (){
                      callTransactionsPage(context, data['username'].toString(), data['uid'].toString());
                    },
                    title: Text(data['username']),
                    leading: CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Text('${data['username'].toString()[0].toUpperCase()}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    ),

                  );
                }).toList())),
              ],

            ),
          );

        }
        else
          return Center(
            child: Text("Something went wrong"),
          );
      },

    );
  }
}

