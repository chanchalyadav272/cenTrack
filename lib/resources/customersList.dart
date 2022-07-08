import 'package:flutter/material.dart';
import 'package:khatabook_clone/resources/customersData.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 0),
    child: ListView.builder(
    itemCount: CustomerData.length,
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
                title:  Text(CustomerData[index]['username'].toString(),),
                subtitle: (int.parse(CustomerData[index]['netAmount'].toString()))>=0 ? null :
                Row(
                  children: [
                    Icon(Icons.alarm, size: 18,),
                    Text(' Set due date')
                  ],
                ),
                leading: CircleAvatar(
                    backgroundColor: Colors.black12,
                  child: Text('${CustomerData[index]['username'].toString()[0]}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                trailing: Text('₹ ${(int.parse(CustomerData[index]['netAmount'].toString())).abs()}',
                style: TextStyle(
                  color: (int.parse(CustomerData[index]['netAmount'].toString()))>=0 ? Colors.green : Colors.red
                ),),
              ),
            ),
          ),
          Divider(height: 4,)
        ],
      );
    }),);
  }
}
