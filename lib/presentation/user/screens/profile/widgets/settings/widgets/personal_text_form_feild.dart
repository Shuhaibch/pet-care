import 'package:flutter/material.dart';

class PersonalTextFormFeild extends StatelessWidget {
  const PersonalTextFormFeild({
    super.key,
    required this.controller,
     this.hintText,
    this.obscureText = false,
    this.sufixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.maxLines = 1,
    this.labelText,
  });
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final Widget? sufixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final int? maxLines;
  final String? labelText;
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
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.displaySmall,
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
