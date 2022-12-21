import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezo_instagram/Screens/login.dart';
import 'package:tezo_instagram/resources/auth_method.dart';
import 'package:tezo_instagram/utils/colors.dart';
import 'package:tezo_instagram/utils/utils.dart';
import 'package:tezo_instagram/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Uint8List? image;

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  void selectimage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      username: usernameController.text,
      bio: bioController.text,
      file: image!,
      context: context,
    );
    debugPrint("Tried to signUp a User,Response is $res");

    setState(() {
      isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      showSnackBar("SignUp Successful", context);
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
      debugPrint("this is the login check");
      emailController.clear();
      passwordController.clear();
      usernameController.clear();
      bioController.clear();
      // image!.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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
                  Flexible(
                    child: Container(),
                  ),
                  Stack(
                    children: [
                      image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(image!),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 64,
                              child: Icon(
                                Icons.person,
                                size: 100,
                              ),
                            ),
                      Positioned(
                        left: 85,
                        top: 90,
                        child: IconButton(
                          onPressed: selectimage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Flexible(
                    child: SizedBox(
                      height: 24,
                    ),
                  ),
                  TextFieldInput(
                    controller: usernameController,
                    hintText: "Enter your Username",
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 20,
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
                  const Flexible(
                    child: SizedBox(
                      height: 24,
                    ),
                  ),
                  TextFieldInput(
                    controller: bioController,
                    hintText: "Enter your Bio details",
                    textInputType: TextInputType.name,
                  ),
                  const Flexible(
                    child: SizedBox(
                      height: 40,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: InkWell(
                      onTap: signUpUser,
                      child: Container(
                        width: double.infinity,
                        height: 100,
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
                            ? const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Sign Up",
                              ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("Sign Up tapped");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
