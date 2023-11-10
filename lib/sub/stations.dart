import 'package:adminapp/sub/stationDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../addStations.dart';

class Stations extends StatefulWidget {
  const Stations({Key? key}) : super(key: key);

  @override
  State<Stations> createState() => _StationsState();
}

class _StationsState extends State<Stations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stations'),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddStation()));
      }, child: Icon(Icons.add),),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('stations').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData||snapshot.data!.docs.isEmpty){
            return CircularProgressIndicator();
          }else{
            var data=snapshot.data!.docs;
            return  ListView.builder(
                shrinkWrap: true,
                itemCount: data!.length,
                itemBuilder: (BuildContext context,int index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> StationDetails(
                          id:data[index].id,
                          name: data[index]['name'],
                          place: data[index]['place'],
                          link: data[index]['location'],
                          email: data[index]['email'],
                          password: data[index]['password'])));
                    },
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(color: Colors.grey)
                      //   boxShadow: [BoxShadow(offset: Offset(0, 0),spreadRadius: 1,blurRadius: 1,color: Colors.grey)]
                      // ),
                      child: ListTile(
                        leading: Icon(Icons.electric_bolt) ,
                        title: Text(data[index]['name']),
                        subtitle: Text(data[index]['place']),
                      ),
                    ),
                  );

                });
          }

        }
      ),
    );
  }
}
