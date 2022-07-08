import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:khatabook_clone/resources/registeredData.dart';

class RegisteredList extends StatelessWidget {
  const RegisteredList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(padding: EdgeInsets.only(top: 0),
      child: ListView.builder(
          itemCount: RegisteredData.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/transactions');
                    },
                    child: ListTile(
                      title:  Text(RegisteredData[index]['username'].toString(),),

                      leading: CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: Text('${RegisteredData[index]['username'].toString()[0]}',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                      ),

                    ),
                  ),
                ),
                Divider(height: 4,)
              ],
            );
          }),);
  }
}
