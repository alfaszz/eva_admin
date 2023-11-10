import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userView extends StatefulWidget {
  const userView({Key? key, required this.created_time, required this.display_name, required this.password, required this.email, required this.phoneNo, required this.photo_url, required this.userName, required this.userid, }) : super(key: key);

 final Timestamp created_time;
  final String display_name;
  final String password;
  final String email;
  final String phoneNo;
  final String photo_url;
  final String userName;
  final String userid;
  // final double wallet;






  @override
  State<userView> createState() => _userViewState();
}

class _userViewState extends State<userView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
        Container(
      height: 500,
      child:   Padding(

        padding: const EdgeInsets.all(15.0),

        child:   Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children:

              [
                Image.network(widget.photo_url,height: 150,),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text('user Name',

                  style: TextStyle(

                      fontSize: 20

                  ),

                ),

                Text(widget.display_name,style: TextStyle(            fontSize: 20



                ),)

              ],

            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text('user email',

                  style: TextStyle(

                      fontSize: 20

                  ),

                ),

                Text(widget.userName,style: TextStyle(            fontSize: 15



                ),)

              ],

            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text('phone',

                  style: TextStyle(

                      fontSize: 20

                  ),

                ),

                Text(widget.phoneNo,style: TextStyle(            fontSize: 20



                ),)

              ],

            ),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text('password',

                  style: TextStyle(

                      fontSize: 20

                  ),

                ),

                Text(widget.password,style: TextStyle(            fontSize: 20



                ),)

              ],

            ),
SizedBox(height: 30,),

                InkWell(
                  onTap: (){
                    FirebaseFirestore.instance.collection('users').doc(widget.userid).delete();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
decoration: BoxDecoration(
  color: Colors.red,
  borderRadius: BorderRadius.circular(15)
),
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Center(child: Text('Delete User',style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600
  ),)),
),
                  ),
                )








              ],

        ),

      ),
    ),
  ],
),
    );
  }
}
