import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../../../../application/bloc/chat/chat_bloc.dart';
import '../../../widgets/widget.dart';
import '../widget/widgets.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});
  final String imageUrl =
      'https://imgs.search.brave.com/cb4ekmNNh1Ynv3bIRlnc7-z-HPHvqXwU3m4plVS50qc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cmQuY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzAzL0dl/dHR5SW1hZ2VzLTEz/NTE1NzgyOC5qcGc';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBloc>().add(NewChatGetAllUser());
    });
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_outlined,
            color: Colors.white,
          ),
        ),
        titleSpacing: .01,
        title: Text(
          "New Chat",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is NewChatGetallUserSuccess) {
            final List<MyUser> userlist = state.userList
                .where(
                  (element) =>
                      element.id != FirebaseAuth.instance.currentUser!.uid &&
                      element.userRole != "Admin",
                )
                .toList();
            return NewChatList(userList: userlist);
          } else if (state is NewChatGetallUserFailed) {
            return Center(
              child: Text(
                'Error Occured',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
          }
          return const CustCircularProgress();
        },
      ),
    );
  }
}
