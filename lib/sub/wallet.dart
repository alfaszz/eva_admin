import 'package:adminapp/sub/wallet%20info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('amount')
                .where('verified', isEqualTo: false)
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
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletInfo(
                                      amount: data?[index]['amount'],
                                      time: data?[index]['date'],
                                      image: data?[index]['image'],
                                      userid: data?[index]['userId'],
                                      verfication: data?[index]['verified'],
                                      rechargID: data?[index]['rechargeId'],
                                  username: data?[index]['userName'],
                                  useremail: data?[index]['email'],
                                    )));
                      },
                      child: ListTile(
                        title: Text((data?[index]['amount']).toString()),
                        subtitle: Text(data?[index]['userId']),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
