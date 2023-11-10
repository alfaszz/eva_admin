import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class requestView extends StatefulWidget {
  final DocumentSnapshot data;
  const requestView({Key? key, required this.data, }) : super(key: key);



  @override
  State<requestView> createState() => _requestViewState();
}

class _requestViewState extends State<requestView> {

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
                    Text(widget.data['userName'].toString(),style: TextStyle(
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
                    Text(widget.data['userEmail'].toString(),style: TextStyle(
                        fontSize: 20
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('station id',style: TextStyle(
                        fontSize: 20
                    ),),
                    Text(widget.data['stationId'].toString(),style: TextStyle(
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
                    Text("Rs "+widget.data['estimatePrice'].toStringAsFixed(2),style: TextStyle(
                        fontSize: 20
                    ))
                  ],
                ),
                SizedBox(height: 20,),


                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.red)
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance.
                          collection('booking').doc(widget.data['id']).update(
                              {
                                'rejected':true,
                              });

                          Navigator.pop(context);

                        }, child: Text("Reject")),

                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.green)
                        ),
                        onPressed: () async {

                          DocumentSnapshot doc= await FirebaseFirestore.instance.collection('users').doc(widget.data['userId']).get();

                          FirebaseFirestore.instance.collection('users').doc(widget.data['userId']).update(
                              {'wallet':doc.get('wallet')-widget.data['estimatePrice']
                              });
                          FirebaseFirestore.instance.collection('amount').add({
                            'userId':widget.data['userId'],
                            'userName':widget.data['userName'],
                            'email':widget.data['userEmail'],
                            'amount': widget.data['estimatePrice'],
                            'image': '',
                            'date':DateTime.now(),
                            'verified':true,
                            'rejected':false
                          }).then((value) {
                            value.update({
                              'rechargeId': value.id
                            });
                          });

                          FirebaseFirestore.instance.
                          collection('booking').doc(widget.data['id']).update({
                            'verified':true,
                            'rejected':false
                          });
                          
                          DocumentSnapshot station =await FirebaseFirestore.instance.collection('stations').doc(widget.data['stationId']).get();
var balance = station.get('balance');
var estimatedPrice = widget.data['estimatePrice'];
                          FirebaseFirestore.instance.collection('stations').doc(widget.data['stationId'])
                              .update({
                            'balance': balance + estimatedPrice
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
