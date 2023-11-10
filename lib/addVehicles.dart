import 'dart:io';

import 'package:adminapp/home/adminHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}
class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  String vehicleType='';


  TextEditingController vehicleName = TextEditingController();
  TextEditingController vehicleModel = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  String imageurl='';
  int selected=1;



  getimage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    showUploadMessage(context, 'uploading...',showLoading: true);
    image=File(image!.path);

    DocumentSnapshot id = await FirebaseFirestore
        .instance
        .collection('settings')
        .doc("settings")
        .get();
    id.reference.update(
        {"images": FieldValue.increment(1)});
    var imageId = id['images'];

    var reference = await storage.ref().child("profileImages/$imageId").putFile(image!);

    var url = await reference.ref.getDownloadURL();
    setState(() {
      imageurl=url;
      showUploadMessage(context, 'image uploaded succcessfully');
    });
    print(url);
    print('==============================');

    if(mounted){
      setState(() {

        image=File(image!.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Vehicle'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: ListView(
    children: [
    Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(left: 20,top: 40,right: 20,bottom: 40),
    child:  Text('Enter Vehicle Details',
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
            child: Column(
              children: [
                Icon(Icons.camera_alt_outlined,size:30,color:Colors.black),
                Text('Upload Vehicle Image',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            )
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
                child: Image.network(imageurl),
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
          controller: vehicleName,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Vehicle Manufacturer Name',
          ),),),
      SizedBox(height: 20,),
      Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: TextField(
          controller: vehicleModel,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Model Name',
          ),),),
      SizedBox(height: 20,),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text('Vehicle Type',
          style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),

      CustomRadioButton(

        height: height*0.1,
        elevation: 0,
        defaultSelected: 1,
        absoluteZeroSpacing: true,
        unSelectedColor: Theme.of(context).canvasColor,
        buttonLables: [
          'Two Wheeler',
          'Three Wheeler',
          'Four Wheeler',
        ],
        buttonValues: [
          1,2,3

          // 'Two Wheeler',
          // 'Three Wheeler',
          // 'Four Wheeler',
        ],
        buttonTextStyle: ButtonTextStyle(
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
            textStyle: TextStyle(fontSize: 16)),
        radioButtonValue: (value) {
          print(value);
          selected = value as int;
          print(selected);
// vehicleType = value.toString();
// print(vehicleType);
          // print(vehicleType);
          },
        selectedColor: Colors.blue,
      ),





        ]
    )
    ),
      bottomSheet:       Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: (){
            print(selected);

            if(selected!=0){

              FirebaseFirestore.instance.collection('vehicle').add({
                'image':imageurl,
                'date':DateTime.now(),
                'brand':vehicleName.text.toUpperCase(),
                'model':vehicleModel.text.toUpperCase(),
                'vehicleType':selected==1?'Two Wheeler':selected==2?'Three Wheeler':'Four Wheeler'
                // 'vehicleType':vehicleType
              }).then((value){
                value.update({
                  'id':value.id
                });
              });
              Navigator.pop(context);

            }
            else{
            }
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Text('Add Vehicle',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),)),
          ),
        ),
      ),

    );
  }
}