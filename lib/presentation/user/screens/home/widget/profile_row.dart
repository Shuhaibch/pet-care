// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../config/config.dart';
import 'widget.dart';

class ProfileRowInMainCard extends StatelessWidget {
  const ProfileRowInMainCard({
    super.key,
    required this.userName,
    required this.date,
    required this.width,
    required this.height,
    required this.imageUrl,
    this.isAdmin = false,
    this.onTap,
  });
  final String userName;
  final String date;
  final double width;
  final double height;
  final String imageUrl;
  final bool isAdmin;
  final VoidCallback? onTap;

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
        InkWell(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isAdmin
                  ? InkWell(
                      onTap: onTap,
                      child: const Icon(
                        Icons.delete,
                      ),
                    )
                  : const Icon(
                      Icons.more_horiz,
                    )),
        ),
      ],
    );
  }
}
