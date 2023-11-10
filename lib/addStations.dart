import 'dart:io';
import 'package:adminapp/home/adminHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStation extends StatefulWidget {
  const AddStation({Key? key}) : super(key: key);

  @override
  State<AddStation> createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController stationName = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController chargingType = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController pricePerUnit = TextEditingController();
  TextEditingController location = TextEditingController();
  List chargingTypes = [];

  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  String imageurl='';
  getimage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    image=File(image!.path);

    var reference = await storage.ref().child("profileImages").putFile(image!);

    var url = await reference.ref.getDownloadURL();
    setState(() {
      imageurl=url;
    });
    print(url);
    print('==============================');

    if(mounted){
      setState(() {


      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "Add Station",
        ),),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20,top: 40,right: 20,bottom: 40),
                child:  Text('Enter Details to Add a Slot',
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

            imageurl==''?
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: InkWell(
                onTap: (){
                  getimage();
                },
                  child: Icon(Icons.camera_alt_outlined,size:30,color:Colors.black)
              ),
            )
            :Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      width: 100,
                      child: Image.network(imageurl)
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      getimage();
                    },
                      child: Container(
                          child:Text('change image',style:TextStyle(fontWeight: FontWeight.bold),)
                      )
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: TextField(
                controller: stationName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Station Name',
                ),),),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
              child: TextField(
                controller: place,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Place',
                ),),),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
              child: TextField(
                controller: address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),),),

            Container(
              padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
              child: TextField(
                controller: username,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),),),

            Container(
              padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),),),

            Container(
              padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
              child: TextField(
                controller: location,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location Link',
                ),),),

            Container(
              padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
              child: TextField(
                controller: time,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                ),),),


            Container(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone',
                ),),),

            Container(
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              child: TextField(
                controller: pricePerUnit,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price Per Unit',
                ),),),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: TextField(
                      controller: chargingType,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Charging Type',
                      ),),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0,right: 15,top: 20),
                  child: InkWell(
                    onTap: (){
                      if(chargingType.text!=''){
                        chargingTypes.add(chargingType.text);
                        setState(() {
                          print(chargingTypes);
                        });
                        chargingType.text='';

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('please enter charging type'),
                        ));
                      }
                    },
                    child: Container(width: 100,
                    height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Add",
                          style: TextStyle(
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),



                    ),
                  ),
                )

              ],
            ),

            ListView.builder(
              itemCount: chargingTypes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,int index){
              return Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Container(
                  height: 30,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: double.infinity,
                   color: Colors.blue[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chargingTypes[index]),
                     InkWell(
                         onTap: (){
                           chargingTypes.removeAt(index);
                           setState(() {

                           });
                         },

                         child: Icon(Icons.delete,size: 25,color: Colors.red,))
                    ],
                  ),
                ),
              );
            }),

            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 40),
              child: InkWell(
                onTap: (){
                  if(stationName.text!=''&& place.text!=''&& address.text!=''&& phone.text!=''
                  && time.text!='' && pricePerUnit.text!='' && chargingTypes.isNotEmpty){
                    FirebaseFirestore.instance.collection('stations').add({
                      'search':setSearchParam(stationName.text.toUpperCase()+' '+place.text.toUpperCase()),
                      'name':stationName.text,
                      'place':place.text,
                      'address':address.text,
                      'location':location.text,
                      'phone':phone.text,
                      'time':time.text,
                      'pricePerUnit':pricePerUnit.text,
                      'chargingTypes':chargingTypes,
                      'saved':[],
                      'email':username.text,
                      'password':password.text,
                      'openFrom': '9:00 AM',
                      'openTill':'11:30 PM',
                      'available':true,
                      'balance':0,
                    }).then((value) => {
                      value.update({
                        'id':value.id
                      })
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Station added successfully'),));


                  }
                  else{
                    stationName.text==''? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please enter Station Name'),))
                        : place.text==''? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please enter Place'),))
                        :address.text==''? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please enter address'),))
                        : phone.text==''? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please enter phone number'),))
                        : time.text==''? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please enter available time'),))
                        : pricePerUnit.text==''? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please enter the price per unit'),))
                        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please add charging types'),
                    ));
                        
                  }
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
