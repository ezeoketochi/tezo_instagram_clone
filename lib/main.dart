import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tezo_instagram/Responsive/mobile_screen_layout.dart';
import 'package:tezo_instagram/Responsive/responsive.dart';
import 'package:tezo_instagram/Responsive/web_screen_layout.dart';
import 'package:tezo_instagram/Screens/homescreen.dart';
import 'package:tezo_instagram/Screens/login.dart';
import 'package:tezo_instagram/Screens/sign_up.dart';
import 'package:tezo_instagram/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAypYH1i0Vpjyfc1Zx3kAJaucAqLeH1p6o",
        appId: "1:541878262817:web:36ce9f21e5b8824c4dd760",
        messagingSenderId: "541878262817",
        projectId: "tezo-instagram-clone",
        storageBucket: "tezo-instagram-clone.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        title: "Instagram Clone",
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: HomeScreen(),
                webScreenLayout: WebScreen(),
              );
            } else if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasError) {
              return Center(
                child: Text(
                  "${snapshot.error}",
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        )),
  );
}
