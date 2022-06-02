import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_s/screens/EMAIL_AUTH/login_screen.dart';
import 'package:fire_s/screens/home_screen.dart';
import 'package:fire_s/screens/phone_Auth/sign_in_with.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("VqMlNEqM9t8bu7XQ8jbZ ")
  //     .get();
  // log(snapshot.data().toString());

  // for (var doc in snapshot.docs) {
  //   log(doc.data().toString());
  // }
  // // log(snapshot.docs.toString());

//data add
  // Map<String, dynamic> newUsers = {
  //   "name": "SlantCode",
  //   "Email": "slantcode@gmail.com"
  // };
  // await _firestore.collection("users").doc("your-id-here").set(newUsers);
  // log("new saved user ");
  //update
  // await _firestore
  //     .collection("users")
  //     .doc("your-id-here")
  //     .update({"email": "test@gmail"});
  // log("new saved user ");
  // delete data
  // await _firestore.collection("users").doc("your-id-here").delete();
  // log("user Delleted");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomeScreen()
          : SignInWithPhone(),
      // home: SignInWithPhone(),
    );
  }
}
