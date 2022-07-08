import 'package:flutter/material.dart';
import 'package:khatabook_clone/resources/customersList.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final String displayName = "hie";
  int _currentIndex = 0;
  int netAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
                  Text(displayName,
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
                child: Text('${displayName[0]}',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                // height: 35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
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
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 8),
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
                            flex: 3,
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
                                    width: 180,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 24),
                                      child: ListTile(
                                        title: netAmount==0? Text('Settled Up',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),) : Text('Amount Due',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),),
                                        leading: netAmount==0? CircleAvatar(
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
                                child: Text('₹ ${(netAmount).abs()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: netAmount>=0 ? Colors.green : Colors.red,


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
                      )
                      ),
                  // CustomersList(),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
