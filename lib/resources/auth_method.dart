import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezo_instagram/models/userModel.dart' as model;
import 'package:tezo_instagram/resources/storage_methods.dart';
import 'package:tezo_instagram/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
    required BuildContext context,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        debugPrint(cred.user!.uid.toString());

        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        model.Users user = model.Users(
          username: username,
          email: email,
          uid: cred.user!.uid,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await firestore.collection("users").doc(cred.user!.uid).set(user
            .toJson(),); // this does the same work as the next block of line, it uses the user model.

        // await firestore.collection("users").doc(cred.user!.uid).set({
        //   'username': username,
        //   'email': email,
        //   'uid': cred.user!.uid,
        //   'bio': bio,
        //   'followers': [],
        //   'following': [],
        //   'photoUrl': photoUrl,
        // });

        // await firestore.collection("users").add({
        //   "username" : username,
        // });
        // this uses random digits id for the doc id.

        res = "success";
      } else {
        showSnackBar("Fill all fields", context);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-email") {
        res = "The email is badly formatted.";
      } else if (error.code == "weak-password") {
        res = "Password is weak";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "All fields must be entered";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
