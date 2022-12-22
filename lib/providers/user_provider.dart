import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezo_instagram/models/userModel.dart';
import 'package:tezo_instagram/resources/auth_method.dart';


class UserProvider extends ChangeNotifier{


   User? _user;


  final _authMethods = AuthMethods();



 User get getUser => _user!;

 Future <void> refreshUser() async {
  User user = await _authMethods.getUserDetails() as User;
  _user = user;

  notifyListeners();
 }
}