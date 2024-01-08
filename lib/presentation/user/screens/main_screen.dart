import 'package:flutter/material.dart';
import 'package:pet_care/presentation/user/screens/screen.dart';
import '../widgets/widget.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _pages = [
    const HomeScreen(),
    const ChatScreen(),
    const AddScreen(),
    const ReportScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, index, _) {
          return _pages[index];
        },
      )),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
