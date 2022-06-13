import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_s/screens/phone_Auth/sign_in_with.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'EMAIL_AUTH/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? profilePic;
  void saveUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String ageString = ageController.text.trim();
    int age = int.parse(ageString);
    nameController.clear();
    emailController.clear();
    ageController.clear();
    if (name != "" && email != "" && profilePic != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("profilepictures")
          .child(Uuid().v1())
          .putFile(profilePic!);

      StreamSubscription taskSub = uploadTask.snapshotEvents.listen((snapshot) {
        double percentage =
            snapshot.bytesTransferred / snapshot.totalBytes * 100;
        log(percentage.toString());
      });
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadurl = await taskSnapshot.ref.getDownloadURL();
      taskSub.cancel();
      Map<String, dynamic> usersData = {
        "name": name,
        'email': email,
        'age': age,
        "prfilepic": downloadurl,
        'sampleArray': [name, email, age],
      };
      FirebaseFirestore.instance.collection("users").add(usersData);
      log("user created");
    } else {
      log("please fill  all the Fields ");
    }
    setState(() {
      profilePic = null;
    });
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInWithPhone()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CupertinoButton(
                onPressed: () async {
                  XFile? selelctedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  if (selelctedImage != null) {
                    File convertedFile = File(selelctedImage.path);
                    setState(() {
                      profilePic = convertedFile;
                    });
                    log("Image Selected");
                  } else {
                    log("Image not Selected");
                  }
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      (profilePic != null) ? FileImage(profilePic!) : null,
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email Address"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(hintText: "Age"),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                onPressed: () {
                  saveUser();
                },
                child: Text("Save"),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .orderBy("age")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userMap =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userMap["profilepic"])),
                              title:
                                  Text(userMap["name"] + "(${userMap['age']})"),
                              subtitle: Text(userMap['email']),
                              trailing: IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(index.toString())
                                      .delete();
                                  log("user Delleted");
                                },
                                icon: Icon(Icons.delete),
                              ),
                            );
                          },
                        );
                      } else {
                        return Text("No Data !");
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
