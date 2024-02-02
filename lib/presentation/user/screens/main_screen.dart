import 'package:flutter/material.dart';
import 'package:pet_care/presentation/user/screens/screen.dart';
import '../widgets/widget.dart';
import 'chat/new_chat/new_chat_screen.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _pages = [
    const HomeScreen(),
    const NewChatScreen(),
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
