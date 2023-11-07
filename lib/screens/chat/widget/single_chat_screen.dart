import 'package:flutter/material.dart';
import 'package:pet_care/screens/chat/widget/message_ui.dart';
import 'package:pet_care/screens/chat/widget/type_chat_widget.dart';
import 'single_app_bar.dart';

class SingleChatScreen extends StatelessWidget {
  static const String routeName = '/single';

  get separatorBuilder => null;
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SingleChatScreen(),
    );
  }

  const SingleChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: SingleChatAppBar(height: height, title: "UserName"),
      body: Stack(
        children: [
          //* Chat Ui
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MessageUi(height: height),
          ),
          const TypeChatWidget(),
        ],
      ),
    );
  }
}
