
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';

import '../../widgets/widget.dart';
import 'widget/widgets.dart';
class ChatScreen extends StatelessWidget {
  final String imageUrl =
      'https://imgs.search.brave.com/cb4ekmNNh1Ynv3bIRlnc7-z-HPHvqXwU3m4plVS50qc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cmQuY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzAzL0dl/dHR5SW1hZ2VzLTEz/NTE1NzgyOC5qcGc';

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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //neech podaaa
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
        //Nk bore adichund appo nganokke ndavym
        height: height,
        title: 'Chats',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //* Search bar
            CupertinoSearchTextField(
              backgroundColor: Colors.grey.withOpacity(0.3),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                child: Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
              ),
              suffixIcon: const Icon(
                CupertinoIcons.xmark_circle_fill,
                color: Colors.grey,
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            kheight10,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    width: width,//korch flutter arinjuchtt oru kaaryulla
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
                        Navigator.pushNamed(context, '/single');
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
