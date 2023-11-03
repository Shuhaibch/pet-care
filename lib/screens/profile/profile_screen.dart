import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // static const String routeName = '/profile';
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => const ProfileScreen(),
  //   );
  // }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Screen Profile"),
    );
  }
}
