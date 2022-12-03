import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezo_instagram/Screens/homescreen.dart';
import 'package:tezo_instagram/Screens/sign_up.dart';
import 'package:tezo_instagram/resources/auth_method.dart';
import 'package:tezo_instagram/utils/colors.dart';
import 'package:tezo_instagram/utils/utils.dart';
import 'package:tezo_instagram/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  void loginUser() async {
    setState(() {
      isLoading = true;
    });


    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);


    if (res != "success") {
      setState(() {
        isLoading = false;
      });


      showSnackBar(res, context);
      debugPrint(res);
    } else if (res == "success") {
      setState(() {
        isLoading = false;
      });


      showSnackBar("Login Successful", context);
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });

      debugPrint(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                ),
                SvgPicture.asset(
                  "assets/ic_instagram.svg",
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                TextFieldInput(
                  controller: emailController,
                  hintText: "Enter your Email",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  controller: passwordController,
                  hintText: "Enter your Password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Log In"),
                  ),
                ),
                Flexible(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("Sign Up tapped");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                      ),
                      TextButton(
                        child: const Text(
                          "Sign Up.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const SignUpScreen()),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
