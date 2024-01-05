// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  LikeButton({super.key, required this.isLiked, required this.onTap});
  final bool isLiked;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isLiked
          ? const Icon(
              Icons.favorite_sharp,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border,
            ),
    );
  }
}
