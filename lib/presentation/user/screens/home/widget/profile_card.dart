import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(7),
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
        Icons.error,
        size: 50,
      ),
    );
  }
}
