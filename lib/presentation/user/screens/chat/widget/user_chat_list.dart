import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/presentation/user/screens/chat/widget/widgets.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../app_view.dart';
import '../../../../../config/config.dart';

class UserChatList extends StatelessWidget {
  const UserChatList({
    super.key,
    required this.chatList,
  });
  final List<ChatMessage>? chatList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          //* Search bar

          // kheight10,
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                // final ChatMessage recieverUser = chatList![index];
                return Container(
                  width: width,
                  height: height * .105,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.25),
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                  ),

                  //* Single Row
                  child: InkWell(
                    onTap: () {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                        builder: (context) => SingleChatScreen(recieverUser: MyUser.empty),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Row(
                        children: [
                          //* Profile Image
                          ProfilePicture(
                            width: width * .17,
                            height: height * .08,
                            imageUrl: 'recieverUser.profilePic ??' "",
                          ),
                          kwidth20,

                          //* Name And Chat
                          SizedBox(
                            width: width * .45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'recieverUser.name',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                Text(
                                  'recieverUser.userRole',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Padding(
                          //   padding: const EdgeInsets.all(12.0),
                          //   child: Text(
                          //     '02/03/2001',
                          //     style:
                          //         Theme.of(context).textTheme.titleSmall,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: height * .004,
                // color: Colors.grey[700],
              ),
              itemCount: chatList!.isEmpty ? 0 : chatList!.length,
            ),
          )
        ],
      ),
    );
  }
}
