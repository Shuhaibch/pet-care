import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  const CustomAppBar({
    super.key,
    required this.height,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.refresh,
            color: Theme.of(context).iconTheme.color,
            size: Theme.of(context).iconTheme.size,
            weight: Theme.of(context).iconTheme.weight,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height * .07);
}
