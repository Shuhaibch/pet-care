// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustTextFeild extends StatelessWidget {
  const CustTextFeild({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.sufixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.maxLines,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? sufixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.displayMedium,
        decoration: InputDecoration(
          prefixIconColor: Colors.white,
          suffixIcon: sufixIcon,
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
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
            borderSide: BorderSide(color: Colors.red),
          ),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
