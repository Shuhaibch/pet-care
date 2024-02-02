// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_element
import 'package:chat_repository/chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/app_view.dart';
import 'package:user_repository/user_repository.dart';

import 'single_app_bar.dart';
import 'type_chat_widget.dart';

class SingleChatScreen extends StatelessWidget {
  SingleChatScreen({super.key, this.recieverUser, this.chatList});
  final MyUser? recieverUser;
  final List<ChatMessage>? chatList;
  final FirebaseChatRepository chatRepository = FirebaseChatRepository();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   BlocProvider.of<ChatBloc>(context).add(
    //       GetChat(FirebaseAuth.instance.currentUser!.uid, recieverUser!.id));
    // });
    return Scaffold(
      appBar: SingleChatAppBar(user: recieverUser!),
      body: Stack(
        children: [
          //* Chat Ui
          SizedBox(height: height * .81, child: _buildMessageList()),
          TypeChatWidget(receiverUser: recieverUser!),
        ],
      ),
    );
  }

//* build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: chatRepository.getMessage(
          FirebaseAuth.instance.currentUser!.uid, recieverUser!.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "error ${snapshot.error}",
            style: Theme.of(context).textTheme.displayMedium,
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        return ListView(
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // reverse: true,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            children: snapshot.data!.docs.isEmpty
                ? [
                    Center(
                      child: Text(
                        "Say Hi👋",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    )
                  ]
                : snapshot.data!.docs
                    .map((document) => _buildMessageItem(document))
                    .toList());
      },
    );
  }

//* build message item
  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          top: 5,
          bottom: 5,
        ),
        child: Align(
          alignment: (data['senderId'] == FirebaseAuth.instance.currentUser!.uid
              ? Alignment.topRight
              : Alignment.topLeft),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (data['senderId'] == FirebaseAuth.instance.currentUser!.uid
                  ? Colors.grey.shade200
                  : Colors.blue[200]),
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              data['content'],
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
