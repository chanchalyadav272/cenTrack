
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khatabook_clone/resources/customersList.dart';

class Transactions extends StatefulWidget {

  final customerUid;
  final customerName;
  final transactionPageId;

  const Transactions({Key? key, required this.customerUid, required this.customerName, required this.transactionPageId}) : super(key: key);


  @override
  State<Transactions> createState() => _TransactionsState(customerUid, customerName, transactionPageId);
}

class _TransactionsState extends State<Transactions> {

  CollectionReference transactionPages = FirebaseFirestore.instance.collection('transactionPages');
  final  customerUid;
  final  customerName;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final transactionPageId;
  var _textcontroller = new TextEditingController();
  var _balancecontroller = new TextEditingController();


  int _currentIndex = 0;
  int balance = 0;

  _TransactionsState(this.customerUid, this.customerName, this.transactionPageId);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState((){});

    setState((){});



  }



  void sendAmount(int amount){

    if(amount == '') return;
    setState((){
      balance -= amount;
    });
    transactionPages.doc(transactionPageId).collection('transactions').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'amount': amount,
      'bool': "true",
      'balance': balance
    }).then((value) => _textcontroller.text = '');





  }
  void getAmount(int amount){
    if(amount == '') return;
    setState((){
      balance += amount;
    });
    transactionPages.doc(transactionPageId).collection('transactions').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'amount': amount,
      'bool' : "false",
      'balance': balance,
    }).then((value) => _textcontroller.text = '');


  }




  @override


  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed:(){  setState((){});},
            child: Icon(Icons.refresh),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          leading: GestureDetector(
            onTap: (){Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false) ;},

            child: Icon(
                Icons.arrow_back
            ),
          ),
          title:
          // Container(
          //   height: 50,
          //   width: MediaQuery.of(context).size.width*0.7,
          //   color: Colors.white,
          //
          //   child:
          ListTile(
            title: Row(
              children: [
                Text(customerName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Customer',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                        ),),
                    ),
                  ),
                )
              ],
            ),
            subtitle: Text('Click here to view settings',
              style: TextStyle(
                  color: Colors.white70
              ),),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('${customerName[0].toUpperCase()}',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),),
            ),

          ),
          centerTitle: true,
          // ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.call),
            )
          ],
          backgroundColor: Colors.blueAccent.shade700,
        ),
        bottomNavigationBar: new Stack(
          clipBehavior: Clip.none, alignment: new FractionalOffset(.5, 1.0),
          children: [
            new Container(
              height: 70.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
              ),
            ),
            // new Padding(
            //   padding: const EdgeInsets.only(bottom: 12.0),
            //   child: new FloatingActionButton(
            //     // notchMargin: 24.0,
            //     onPressed: () => print('hello world'),
            //     child: new Icon(Icons.arrow_back),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Container(
                // height: 35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: (){
                            print('you gave');
                            sendAmount(int.parse(_textcontroller.text));
                          },
                          child: Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('YOU GAVE  ₹',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(6))
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: GestureDetector(
                        onTap: (){
                          getAmount(int.parse(_textcontroller.text));
                        },
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('YOU GOT  ₹',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(6))
                          ),
                        ),
                      ),
                    ))

                  ],
                ),
              ),
            )
          ],
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
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // width: MediaQuery.of(context).size.width*0.7,
                                // color: Colors.red,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 24),
                                        child: ListTile(
                                            title: balance==0? Text('Settled Up',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),) : Text('Amount Due',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold
                                              ),),
                                            leading: balance==0? CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.green,
                                              child: Icon(Icons.check_outlined,
                                                size: 16,),
                                            ) : CircleAvatar(
                                              backgroundColor: Colors.orange,
                                              child: Icon(Icons.pending_outlined),
                                            )

                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  // color: Colors.green,
                                  child: Text('₹ ${(balance).abs()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: balance>=0 ? Colors.green : Colors.red,


                                    ),),
                                ))
                          ],
                        ),
                      ),
                    ),),
                  SizedBox(height: 7,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    color: Colors.red,

                    child: BottomNavigationBar(
                      currentIndex: _currentIndex,
                      onTap: (value){
                        _currentIndex = value;
                        setState((){});
                      },

                      elevation: 0,
                      selectedItemColor: Colors.blue,
                      unselectedItemColor: Colors.grey,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf), label: ('Report'),),
                        BottomNavigationBarItem(icon: Icon(Icons.currency_rupee_outlined), label: 'Payment'),
                        BottomNavigationBarItem(icon: Icon(Icons.whatsapp), label: 'Reminder'),
                        BottomNavigationBarItem(icon: Icon(Icons.sms_outlined), label: 'SMS'),


                      ],
                    ),

                  ),
                  Container(
                    // color: Colors.red,
                    child: IntrinsicHeight(

                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(


                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.all(Radius.circular(0))
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: TextFormField(
                                  autofocus: false,
                                  textAlign: TextAlign.left,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.number,
                                  controller: _textcontroller,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                                  decoration: InputDecoration(

                                      prefixIcon: Icon(Icons.currency_rupee_outlined),
                                      hintText: 'Enter amount',
                                      hintStyle: TextStyle(
                                          color: Colors.grey
                                      ),
                                      border: InputBorder.none

                                  ),
                                ),
                              ),

                            ),

                          ),


                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 40,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(child: Container(

                            child: Text('ENTRIES',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                            alignment: Alignment.center,
                          )),
                          Expanded(child: Container(

                            child: Text('YOU GAVE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                            alignment: Alignment.center,
                          )),
                          Expanded(child: Container(

                            child: Text('YOU GOT',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),
                            alignment: Alignment.center,
                          )),

                        ],
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('transactionPages').doc(transactionPageId)
                            .collection('transactions').orderBy('createdOn', descending: true).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                        { print(transactionPageId);

                          if (snapshot.hasError){
                            return Center(
                              child: Text("Something went wrong"),
                            );
                          }
                          // if (snapshot.connectionState == ConnectionState.waiting){
                          //   return Center(
                          //     child: SpinKitChasingDots(
                          //       color: Colors.black,
                          //       size: 50,
                          //     ),
                          //   );
                          // }
                          if( snapshot.hasData){


                            return Container(
                              child: Column(
                                children: [

                                  Container(
                                    // color: Colors.grey,
                                    height: MediaQuery.of(context).size.height*0.5,
                                    child: ListView(
                                      reverse: false,
                                      children:
                                      snapshot.data!.docs.map((DocumentSnapshot document){
                                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                                        balance = data['balance'] as int;
                                        print(balance);


                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 4),
                                          child: Container(
                                            color: Colors.white,

                                            height: 100,
                                            child: Row(
                                              children: [
                                                Expanded(child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
                                                  child: Container(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            data['createdOn'] == null
                                                                ? DateTime.now().toString() : data['createdOn'].toDate().toString()
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.black12,
                                                                  borderRadius: BorderRadius.all(Radius.circular(4))
                                                              ),

                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                                child: Text('Bal. ₹ ${(data['balance'] as int).abs()}',
                                                                style: TextStyle(color: (data['balance'] as int)>=0
                                                                ? Colors.green : Colors.red),),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                  flex: 1,),
                                                Expanded(child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(45, 25, 45, 50),
                                                  child: Container(

                                                      child: Text('₹ ${(data['amount'])}' ,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18,
                                                            color:
                                                            (getALignment(data['uid'].toString(), data['bool']) == Alignment.centerLeft)
                                                                ? Colors.red : Colors.green
                                                        ),),
                                                      alignment: getALignment(data['uid'].toString(), data['bool'])
                                                  ),
                                                ),
                                                  flex: 2,),

                                              ],
                                            ),
                                          ),
                                        );

                                      }).toList(),



                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            );



                          }
                          else  return Center(
                            child: Text("Something went wrong cilacb lic iaeci"),
                          );


                        },
                      ),
                    ),
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isSender(String sender) {
    return sender == currentUserId;
  }
  Alignment getALignment(String sender, String isSent){
    if( sender == currentUserId){
      if(isSent == 'true'){
        return Alignment.centerLeft;
      }
      else return Alignment.centerRight;
    }
    else{
      if(isSent == 'true'){
        return Alignment.centerRight;
      }
      else return Alignment.centerLeft;
    }

  }
}