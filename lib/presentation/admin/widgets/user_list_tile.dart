import 'package:flutter/material.dart';
import 'package:pet_care/config/width.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.height,
    required this.title,
    required this.userRole,
    // required this.imageSize,
  });

  final double height;
  final String title;
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.9),
      child: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        // height: height * .1,
        decoration: BoxDecoration(
          color: userRole == 'User'
              ? Colors.grey[900]
              : userRole == 'Forest'
                  ? Colors.green[900]
                  : userRole == 'Police'
                      ? Colors.blue[900]
                      : Colors.red[900],
          borderRadius: const BorderRadius.all(
            Radius.elliptical(20, 20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              // child: Image(
              //   alignment: Alignment.center,
              //   height: 80,
              //   image: AssetImage(
              //     imagelocation,
              //   ),
              //   fit: BoxFit.cover,
              // ),
            ),
            kwidth20,
            Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  userRole,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
