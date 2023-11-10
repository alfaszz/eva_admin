import 'package:adminapp/addStations.dart';
import 'package:adminapp/sub/WithdrawReq.dart';
import 'package:adminapp/sub/requests.dart';
import 'package:adminapp/sub/stations.dart';
import 'package:adminapp/sub/transactions.dart';
import 'package:adminapp/sub/users.dart';
import 'package:adminapp/sub/wallet.dart';
import 'package:flutter/material.dart';
import '../sub/vehicles.dart';

setSearchParam(String caseNumber) {
  List<String> caseSearchList = <String>[];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}
var size,height,width;
class AdHome extends StatefulWidget {
  const AdHome({Key? key}) : super(key: key);

  @override
  State<AdHome> createState() => _AdHomeState();
}
class _AdHomeState extends State<AdHome> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text("Admin Panel",),),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Requests(),));
                },
                child: Container(
                  height: height*0.25, width: width*0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/icons/request.png',height: 120),
                      Text('Requests',style: TextStyle(fontWeight: FontWeight.bold),),

                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Stations()));
                  },

                  child: Container(
                    height: height*0.2,
                    width: width*0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20) ,
                      color: Colors.blue[100],
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Image.asset('assets/icons/charging.png',height: 120),
                      Text(
                        "Stations",
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // fontSize: 20
                      ),
                      ),
                    ],
                  ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Users(),));
                  },

                  child: Container(
                    height: height*0.2,
                    width: width*0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20) ,
                      color: Colors.blue[100],
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/icons/users.png',height: 120),
                      Text('Users', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),),
                ),
              ],),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Transactions(),));
                  },
                  child: Container(
                    height: height*0.2,
                    width: width*0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20) ,
                      color: Colors.blue[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/icons/transaction.png',height: 120),
                        Text('Transactions', style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Wallet(),));
                  },
                  child: Container(
                    height: height*0.2,
                    width: width*0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20) ,
                      color: Colors.blue[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/icons/wallet.png',height: 120),
                        Text('Pending Payments',style: TextStyle(fontWeight: FontWeight.bold),),

                      ],
                    ),),
                ),
              ],),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Vehicle()));
                  },
                  child: Container(
                    height: height*0.2,
                    width: width*0.4,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20) ,
                        color: Colors.blue[100],
                      ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Image.asset('assets/icons/vandi.png',height: 140),
                        Text("Vehicles", style: TextStyle(
                            fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const WithdrawReq()));
                  },
                  child: Container(
                    height: height*0.2,
                    width: width*0.4,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(20) ,
                      color: Colors.blue[100],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        Image.asset('assets/icons/seller.png',height: 140),
                        Text("Merchant", style: TextStyle(
                          fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
