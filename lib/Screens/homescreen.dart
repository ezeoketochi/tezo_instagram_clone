import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
             username =  snapshot["username"].toString();
        });
  }

  @override
  Widget build(BuildContext context) {
        getUsername();

    return  Scaffold(
      body: Center(
        child: username == "" ? const CircularProgressIndicator() : Text(
          "Username is $username",
        ),
      ),
    );
  }
}
