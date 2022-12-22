import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  Users({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    this.followers = const [],
    this.following = const [],
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "photoUrl": photoUrl,
        "username": username,
        "bio": bio,
        "followers": followers,
        "following": following,
      };



      static Users fromSnap (DocumentSnapshot snap){
        var snapshot = snap.data() as Map<String , dynamic>;


        return Users(email: snapshot["email"], uid: snapshot["uid"], photoUrl: snapshot["photoUrl"], username: snapshot["username"], bio: snapshot["bio"],);
      }
}
