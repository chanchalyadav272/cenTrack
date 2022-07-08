import 'package:flutter/material.dart';
import 'package:khatabook_clone/resources/registeredList.dart';

import '../resources/customersList.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false) ;},
          icon: Icon(Icons.arrow_back_sharp,
          color: Colors.blueAccent.shade700,),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IntrinsicHeight(

              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(


                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          textAlignVertical: TextAlignVertical.center,

                          decoration: InputDecoration(

                              suffixIcon: Icon(Icons.search),
                              hintText: 'Enter customer name to add entries',
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
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 0),
              child: Container(
                child: ListTile(
                  title: Text('Add New Customer',
                  style: TextStyle(
                    color: Colors.blue
                  ),),
                  leading: Icon(Icons.add_circle_outline_outlined,
                  size: 45,
                  color: Colors.blue,),
                  trailing: Icon(Icons.arrow_forward_ios_outlined,
                  size: 20, color: Colors.blue,),
                ),

              ),
            ),
            Divider(height: 2,),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Container(

                  height: MediaQuery.of(context).size.height*0.7,
                  child:  RegisteredList()),
            ),



          ],
        ),
      )
    );
  }
}
