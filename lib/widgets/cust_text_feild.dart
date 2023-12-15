import 'package:flutter/material.dart';

class CustTextFeild extends StatelessWidget {
  const CustTextFeild({
    super.key,
    required this.cusIcon,
    required this.hintText,
    required this.controller,
    this.suffIcon,
  });
  final IconData? cusIcon;
  final Widget? suffIcon;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.displayMedium,
        decoration: InputDecoration(
          suffixIcon: suffIcon,
          suffixIconColor: Colors.white,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.displayMedium,
          filled: true,
          fillColor: Colors.grey.withOpacity(.25),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            borderSide: BorderSide(color: Colors.white),

          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: Icon(
            cusIcon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
