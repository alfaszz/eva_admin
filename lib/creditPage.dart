import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('amount').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data?.docs;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context,index){
                  Timestamp d =(data?[index]['date']);
                  var t = d.toDate();


                  return ListTile(
                    leading: Icon(Icons.call_received,color: Colors.green,),
                    trailing: Text('\$ '+(data?[index]['amount']).toStringAsFixed(2)),
                    title: Text(data?[index]['userName']),
                    subtitle: Text(DateFormat.yMd().add_jm().format(t).toString()),
                  );
                }
            );
          }
      )

    );
  }
}