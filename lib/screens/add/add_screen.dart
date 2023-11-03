import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  // static const String routeName = '/add';
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => const AddScreen(),
  //   );
  // }

  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Screen Add"),
    );
  }
}
