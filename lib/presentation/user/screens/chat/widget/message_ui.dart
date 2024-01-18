import 'package:flutter/material.dart';
import 'package:pet_care/models/chats.dart';

// ignore: must_be_immutable
class MessageUi extends StatefulWidget {

  MessageUi({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<MessageUi> createState() => _MessageUiState();
}

class _MessageUiState extends State<MessageUi> {
  List<ChatMessageDummy> messages = [
    ChatMessageDummy(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessageDummy(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessageDummy(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessageDummy(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessageDummy(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            top: 10,
            bottom: 10,
          ),
          child: Align(
            alignment: (messages[index].messageType == "receiver"
                ? Alignment.topLeft
                : Alignment.topRight),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: (messages[index].messageType == "receiver"
                    ? Colors.grey.shade200
                    : Colors.blue[200]),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                messages[index].messageContent,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        );
      },
    );
  }
}
