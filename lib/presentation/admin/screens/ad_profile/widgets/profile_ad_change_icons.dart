
import 'package:flutter/material.dart';

class ChangeProfileIconRow extends StatelessWidget {
  const ChangeProfileIconRow({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.title,
  });

  final double width;
  final double height;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width * .13,
          height: height * .35,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 1,
            ),
          ),
          child: InkWell(
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Text(title)
      ],
    );
  }
}
