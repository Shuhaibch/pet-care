import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const SizedBox(
          height: 2.0,
          width: 2.0,
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 100, 6, 6),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.person,
          color: Colors.grey,
          size: 50,
        ),
      ),
    );
  }
}
