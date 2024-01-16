import 'package:flutter/material.dart';
import 'message_ui.dart';
import 'single_app_bar.dart';
import 'type_chat_widget.dart';

class SingleChatScreen extends StatelessWidget {
  // static const String routeName = '/single';

  // get separatorBuilder => null;
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => const SingleChatScreen(),
  //   );
  // }

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
