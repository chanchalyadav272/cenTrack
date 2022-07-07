import 'package:flutter/material.dart';

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
          color: Colors.blue,),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
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
                        border: Border.all(color: Colors.grey),
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

        ],
      )
    );
  }
}
