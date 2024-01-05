import 'package:flutter/material.dart';
import 'package:pet_care/config/width.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    super.key,
    required this.height,
    required this.title,
    // required this.imageSize,
    required this.imagelocation,
  });

  final double height;
  final String title;
  final String imagelocation;
  // final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.9),
      child: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        height: height * .19,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.all(
            Radius.elliptical(20, 20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 55,
              child: Image(
                alignment: Alignment.center,
                height: 80,
                image: AssetImage(
                  imagelocation,
                ),
                fit: BoxFit.cover,
              ),
            ),
            kwidth20,
            Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
            )
          ],
        ),
      ),
    );
  }
}
