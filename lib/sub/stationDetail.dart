import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
 class StationDetails extends StatefulWidget {
   const StationDetails({Key? key, required this.name, required this.place, required this.link, required this.email, required this.password, required this.id}) : super(key: key);

   @override
   State<StationDetails> createState() => _StationDetailsState();
   final String name;
   final String place;
   final String link;
   final String email;
   final String id;
   final String password;

 }



 class _StationDetailsState extends State<StationDetails> {
   final name =TextEditingController();
   final place =TextEditingController();
   final link= TextEditingController();
   final email= TextEditingController();
   final password= TextEditingController();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
    // name.text=widget.name;
  }
  DocumentSnapshot? doc;
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Station Detail'),
         backgroundColor: Colors.blue[900],
       ),
       body: StreamBuilder<DocumentSnapshot>(
         stream: FirebaseFirestore.instance.collection('stations')
           .doc(widget.id).snapshots(),
         builder: (context, snapshot) {
           if(!snapshot.hasData){
             return Center(child: CircularProgressIndicator(),);
           }
           doc=snapshot.data;
           name.text=doc!['name'];
           place.text=doc!['place'];
           link.text=doc!['location'];
           email.text=doc!['email'];
           password.text=doc!['password'];
           return Center(
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   SizedBox(height: 70),

                   TextField(
                     controller: name,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Station Name',
                     ),
                   ),

                   SizedBox(height: 20),

                   TextField(
                     controller: place ,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Place',
                     ),
                   ),

                   SizedBox(height: 20),

                   TextField(
                     controller: link ,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'Link',
                     ),
                   ),

                   SizedBox(height: 20),

                   TextField(
                     controller: email ,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'email',
                     ),
                   ),

                   SizedBox(height: 20),

                   TextField(
                     controller: password,
                     decoration: const InputDecoration(
                       border: OutlineInputBorder(),
                       labelText: 'password',
                     ),
                   ),

                   SizedBox(height: 30),

                   InkWell(
                     onTap: (){
                       if(name.text != ""&&place.text!=''){
                         doc!.reference.update({
                           'name':name.text,
                           'place':place.text,
                           'location':link.text,
                           'email': email.text,
                           'password': password.text,
                         });

                         ScaffoldMessenger.of(context)
                             .showSnackBar(const SnackBar(
                           content: Text('station updated successfully'),
                         ));

                       }
                       else{
                         name.text==''
                             ?ScaffoldMessenger.of(context)
                             .showSnackBar(const SnackBar(content: Text('enter name'),))
                             :ScaffoldMessenger.of(context)
                             .showSnackBar(const SnackBar(content: Text('enter place'),));
                       }

                     },
                     child: Container(
                       height: 50, width: 300,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Colors.blue[900],
                       ),
                       child: Center(child: Text('UPDATE', style: TextStyle(
                           color: Colors.white,fontWeight: FontWeight.bold),)),
                     ),
                   ),



                 ],
               ),
             ),
           );
         }
       ),
     );
   }
 }
