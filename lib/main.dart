import 'package:adminapp/home/adminHome.dart';
import 'package:adminapp/home/adminLogin.dart';
import 'package:adminapp/adminRegister.dart';
import 'package:adminapp/sub/stations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:AdHome()
    );
  }
}

