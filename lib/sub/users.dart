import 'package:adminapp/sub/user_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        //border: Border.all(color: Colors.grey)
                        //boxShadow: [BoxShadow(offset: Offset(0, 0),spreadRadius: 1,blurRadius: 1,color: Colors.grey)]
                      ),
                      child: InkWell(
                        onTap:(){
                           // double walletbalance = data[index]['wallet'] == null ?0.0:double.tryParse((data[index]['wallet']!).toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => userView(
                                      created_time: data[index]['created_time'],
                                      display_name: data[index]['display_name'],
                                      password: data[index]['password'],
                                      email: data[index]['email'],
                                      phoneNo: data[index]['phoneNo'],
                                      photo_url: data[index]['photo_url'],
                                      userName: data[index]['userName'],
                                    userid: data[index]['uid'],
                                    // wallet: walletbalance,

                                  )));
                        },




                        child: ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          title: Text(data[index]['display_name']),
                          subtitle: Text(data[index]['email']),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
