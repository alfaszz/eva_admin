import 'package:adminapp/sub/requestView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Requests'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('booking')
                .where('verified', isEqualTo: false)
                .where('rejected', isEqualTo: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data?.docs;

              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => requestView(
                                data: data![index],
                              )));
                        },
                        child: ListTile(
                          title: Text((data?[index]['userName']).toString()),
                          subtitle: Text(data?[index]['timeNeeded'].toStringAsFixed(2)),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    );
                  });
            }),
      ),

    );
  }
}
