import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({Key? key, required this.amount, required this.time, required this.image, required this.userid, required this.verfication, required this.rechargID, required this.username, required this.useremail}) : super(key: key);

  final double amount;
  final Timestamp time;
  final String image;
  final String userid;
  final String rechargID;
  final String username;
  final String useremail;


  final bool verfication;

  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approval'),
        backgroundColor: Colors.blue[900],

      ),
      body:Center(
        child: Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('user name',style: TextStyle(
                        fontSize: 20
                    ),),
                    Text(widget.username.toString(),style: TextStyle(
                        fontSize: 20
                    ))
                  ],
                ),
SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('user email',style: TextStyle(
                        fontSize: 20
                    ),),
                    Text(widget.useremail.toString(),style: TextStyle(
                        fontSize: 20
                    ))
                  ],
                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount',style: TextStyle(
                        fontSize: 20
                    ),),
                    Text(widget.amount.toString(),style: TextStyle(
                        fontSize: 20
                    ))
                  ],
                ),
                SizedBox(height: 20,),

                Column(
                  children: [
                    Text('Proof',style: TextStyle(
                      fontSize: 20
                    ),),
                    SizedBox(height: 20,),

                    Image.network(widget.image,height: 200,),
                  ],



                ),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red)
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance.collection('amount').doc(widget.rechargID).delete();

                          Navigator.pop(context);

                        }, child: Text("Reject")),

                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.green)
                        ),
                        onPressed: () async {

                         DocumentSnapshot doc= await FirebaseFirestore.instance.collection('users').doc(widget.userid).get();

                          FirebaseFirestore.instance.collection('users').doc(widget.userid).update(
                              {'wallet':doc.get('wallet')+widget.amount });

                          FirebaseFirestore.instance.collection('amount').doc(widget.rechargID).update({
                            'verified':true,
                            'rejected':false
                          });


                          Navigator.pop(context);

                        }, child: Text("Approve"))
                  ],
                )

              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
