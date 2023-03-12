import 'package:bloodapp/project1/home.dart';
import 'package:bloodapp/project1/add.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloodapp/project1/update.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        '/':(context)=>HomePage(),
        '/adduser':(context)=>AddUser(),
        '/update':(context)=>UpdateUser(),

      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
