import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Debit extends StatefulWidget {
  const Debit({Key? key}) : super(key: key);

  @override
  State<Debit> createState() => _DebitState();
}

class _DebitState extends State<Debit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('withDrawRequests').snapshots(),
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
              leading: Icon(Icons.call_made,color: Colors.red,),
              trailing: Text('\$ '+(data?[index]['withdrawAmount']).toString()),
              title: Text(data?[index]['name']),
              subtitle: Text(DateFormat.yMd().add_jm().format(t).toString()),
            );
          }
          );
        }
      )
    );
  }
}
