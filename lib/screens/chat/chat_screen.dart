import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/widgets/widget.dart';

class ChatScreen extends StatelessWidget {
  final String imageUrl =
      'https://imgs.search.brave.com/cb4ekmNNh1Ynv3bIRlnc7-z-HPHvqXwU3m4plVS50qc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cmQuY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzAzL0dl/dHR5SW1hZ2VzLTEz/NTE1NzgyOC5qcGc';

  // static const String routeName = '/chat';
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) => const ChatScreen(),
  //   );
  // }

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
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
                    width: width,
                    height: height * .105,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.25),
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(20, 20),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              child: Image.network(imageUrl),
                            ),
                            placeholder: (context, url) => const SizedBox(
                              height: 2.0,
                              width: 2.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 100, 6, 6),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: height * .003,
                  // color: Colors.grey[700],
                ),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
