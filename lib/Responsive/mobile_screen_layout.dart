import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezo_instagram/providers/user_provider.dart';
import 'package:tezo_instagram/resources/auth_method.dart';
import 'package:tezo_instagram/models/userModel.dart' as model;
import 'package:provider/provider.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  String username = "";

  final auth = AuthMethods();

  void getUsername() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = snapshot["username"];
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.Users user = Provider.of<UserProvider>(context).getUser;

    getUsername();
    return Scaffold(
      body: Center(
        child: username == ""
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                "Username is $username",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
      ),
    );
  }
}
