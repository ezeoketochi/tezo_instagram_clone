import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  TextFieldInput({
    Key? key,
    this.isPass = false,
    required this.controller,
    required this.hintText,
    // required this.inputBorder,
    required this.textInputType,
  }) : super(key: key);

  final bool isPass;
  final String hintText;
  final TextInputType textInputType;

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
        // borderSide: Divider.createBorderSide(context),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
