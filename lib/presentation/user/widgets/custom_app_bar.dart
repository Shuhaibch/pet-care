import 'package:flutter/material.dart';

import '../../../app_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height * .07);
}
