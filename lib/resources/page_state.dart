import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'page_state.g.dart';

class PageState = _PageState with _$PageState;


abstract class _PageState with Store{
  var currentUserId = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference transactionPages = FirebaseFirestore.instance.collection('transactionPages');


  @observable
  Map<String, dynamic> transactions = ObservableMap();

  @action
  void refreshTransactionsForCurrentUser(){
    var transactionDocument = [];

    transactionPages.where('users.$currentUserId' ,isNull: true).snapshots().listen((QuerySnapshot snapshot) {
      transactionDocument = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> names =  data['names'];
        names.remove(currentUserId);

        return {'docid': doc.id, 'name': names.values.first};

      }).toList();

        transactionDocument.forEach((doc) {
          FirebaseFirestore.instance.collection('transactionPages/${doc['docid']}/transactions').orderBy('createdOn' , descending: true)
              .limit(1).snapshots().listen((QuerySnapshot snapshot) {
                if(snapshot.docs.isNotEmpty){
                  transactions[doc['name']] = {
                    'balance': snapshot.docs.first['balance'],
                    'time' : snapshot.docs.first['createdOn'],
                    'customerName': doc['name'],
                    'customerUid': snapshot.docs.first['uid'],
                    'transactionPageId': doc['docid'],
                    'isSender': snapshot.docs.first['bool'],
                  };
                }
          });
              
              
              
              
        });
    });
  }

}