
import 'package:flutter/material.dart';

import '../../../../../config/config.dart';
import 'widget.dart';

class ProfileRowInMainCard extends StatelessWidget {
  const ProfileRowInMainCard({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.userName,
    required this.date,
  });
  final String userName;
  final String date;
  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        kwidth10,

        //* Profile Pic
        SizedBox(
          width: width * .15,
          height: height * .085,
          child: ProfileCard(imageUrl: imageUrl),
        ),
        kwidth20,

        //* Username and Date
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            kheight5,
            Text(
              date,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
        const Spacer(),
        //* icon
        const InkWell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.more_horiz,
            ),
          ),
        ),
      ],
    );
  }
}
