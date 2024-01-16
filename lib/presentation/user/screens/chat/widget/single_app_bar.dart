import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';

import 'profile_widget.dart';

class SingleChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imageUrl =
      'https://imgs.search.brave.com/cb4ekmNNh1Ynv3bIRlnc7-z-HPHvqXwU3m4plVS50qc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cmQuY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzAzL0dl/dHR5SW1hZ2VzLTEz/NTE1NzgyOC5qcGc';

  final double height;
  final String title;
  SingleChatAppBar({
    super.key,
    required this.height,
    required this.title,
  });
  final List<String> catagories = [
    'Contact',
    'Report',
    'Block',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      leadingWidth: width * .09,
      centerTitle: false,
      title: Row(
        children: [
          ProfilePicture(
            width: width * .11,
            height: height * .13,
            imageUrl: imageUrl,
          ),
          kwidth10,
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
            // textAlign: TextAlign.left,
          ),
        ],
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          color: Colors.grey[900],
          itemBuilder: (context) => catagories
              .map((e) => PopupMenuItem(
                      child: Text(
                    e,
                    style: Theme.of(context).textTheme.displaySmall,
                  )))
              .toList(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height * .07);
}
