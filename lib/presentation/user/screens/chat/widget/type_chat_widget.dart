import 'package:chat_repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/application/bloc/chat/chat_bloc.dart';
import 'package:pet_care/config/width.dart';
import 'package:user_repository/user_repository.dart';

class TypeChatWidget extends StatelessWidget {
  const TypeChatWidget({
    super.key,
    required this.receiverUser,
  });
  final MyUser receiverUser;
  @override
  Widget build(BuildContext context) {
    TextEditingController chat = TextEditingController();
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            kwidth10,
            Expanded(
              child: TextField(
                controller: chat,
                textAlign:
                    TextAlign.left, // Aligns text horizontally to the center
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),

                  //* add Button
                  prefixIcon: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Write message...",
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            kwidth10,
            BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                // if (state is SendChatSuccess) {
                // chat.clear();
                // }
              },
              child: FloatingActionButton(
                onPressed: () {
                  final ChatMessage chatMessage = ChatMessage(
                    chatId: '',
                    senderId: FirebaseAuth.instance.currentUser!.uid,
                    receiverId: receiverUser.id,
                    content: chat.text,
                    chatTime: Timestamp.now(),
                  );
                  if (chat.text.isNotEmpty) {
                    context
                        .read<ChatBloc>()
                        .add(SendChat(chatMessage: chatMessage));
                    chat.clear();
                  }
                },
                backgroundColor: Colors.blue[200],
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
