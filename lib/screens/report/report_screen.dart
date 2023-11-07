import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  static const String routeName = '/report';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ReportScreen(),
    );
  }

  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Screen Report"),
    );
  }
}
