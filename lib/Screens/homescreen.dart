import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezo_instagram/models/userModel.dart' as model;

import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String username = "";
 

  @override
  void initState() {
    super.initState();
  }

   void getUsername() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

        // debugPrint(snapshot.data().toString());
        setState(() {
             username = snapshot["username"].toString();
        });
  }

  @override
  Widget build(BuildContext context) {
        getUsername();
        
        
        model.Users user = Provider.of<UserProvider>(context).getUser as model.Users;


    return  Scaffold(
      body: Center(
        child: username == "" ? const CircularProgressIndicator() : Text(
          "email is ${user.email}",
        ),
      ),
    );
  }
}
