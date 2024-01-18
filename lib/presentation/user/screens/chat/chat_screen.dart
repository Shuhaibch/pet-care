
import 'package:flutter/material.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/config/config.dart';

import '../../widgets/widget.dart';
import 'new_chat/new_chat_screen.dart';
import 'widget/widgets.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat';
  static Route route() {
    //board okke upeych show erkknu on
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ChatScreen(),
    );
  }

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String imageUrl =
      'https://imgs.search.brave.com/cb4ekmNNh1Ynv3bIRlnc7-z-HPHvqXwU3m4plVS50qc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cmQuY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzAzL0dl/dHR5SW1hZ2VzLTEz/NTE1NzgyOC5qcGc';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //neech podaaa
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.message_outlined),
        onPressed: () {
          navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => const NewChatScreen(),
          ));
        },
      ),
      appBar: const CustomAppBar(
        title: 'Chats',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //* Search bar

            // kheight10,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    width: width, //korch flutter arinjuchtt oru kaaryulla
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
                          builder: (context) => const SingleChatScreen(recieverUser: null, chatList: []),
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
                              imageUrl: imageUrl,
                            ),
                            kwidth20,

                            //* Name And Chat
                            SizedBox(
                              width: width * .45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Goat Is goat",
                                    //awwff goat is goat, onn poyeda avdnn
                                    style: Theme.of(context)
                                        //prrrrrrrrrrrr patti show
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  Text(
                                    "this is the last message done by",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                '02/03/2001',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            )
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
                itemCount: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
