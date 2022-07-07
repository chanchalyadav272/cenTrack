import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: new Stack(
          clipBehavior: Clip.none, alignment: new FractionalOffset(.5, 1.0),
          children: [
            new Container(
              height: 40.0,
              color: Colors.red,
            ),
            new Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: new FloatingActionButton(
                // notchMargin: 24.0,
                onPressed: () => print('hello world'),
                child: new Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
