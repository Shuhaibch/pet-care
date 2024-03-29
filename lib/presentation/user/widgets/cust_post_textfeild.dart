import 'package:flutter/material.dart';

class CustPostTextFeild extends StatelessWidget {
  const CustPostTextFeild({
    super.key,
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
  });
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        cursorColor: Colors.white,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white,
            ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIconColor: Colors.white,
          suffixIcon: sufixIcon,
          suffixIconColor: Colors.white,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
          filled: false,
          fillColor: Colors.grey.withOpacity(.25),
          enabledBorder: InputBorder.none,
          //  const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          //   borderSide: BorderSide(color: Colors.grey),
          // ),
          focusedBorder: InputBorder.none,
          //  const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          errorBorder: InputBorder.none,
          //  const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          //   borderSide: BorderSide(color: Colors.red),
          // ),
          focusedErrorBorder: InputBorder.none,
          //  const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
          //   borderSide: BorderSide(color: Colors.red),
          // ),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
