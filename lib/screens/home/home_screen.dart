import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';
import '../../widgets/widget.dart';
import 'widget/widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  final String imageUrl =
      'https://imgs.search.brave.com/cb4ekmNNh1Ynv3bIRlnc7-z-HPHvqXwU3m4plVS50qc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly93d3cu/cmQuY29tL3dwLWNv/bnRlbnQvdXBsb2Fk/cy8yMDIxLzAzL0dl/dHR5SW1hZ2VzLTEz/NTE1NzgyOC5qcGc';
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(

      //* App Bar
      appBar: CustomAppBar(
        height: height,
        title: 'Feeds',
      ),
      
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: 5,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: height * .43,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.25),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                //* profile with name and photo
                ProfileRowInMainCard(
                  width: width,
                  height: height,
                  imageUrl: imageUrl,
                ),
                kheight10,

                //* Main Picture
                Container(
                  width: width * .8,
                  height: height * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
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
                ),

                //* Icons
                Padding(
                  padding: const EdgeInsets.only(
                    left: 9.0,
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_border),
                      kwidth20,
                      const Icon(Icons.mode_comment_outlined)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileRowInMainCard extends StatelessWidget {
  const ProfileRowInMainCard({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
  });

  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        kwidth10,

        //* Profile Pic
        SizedBox(
          width: width * .15,
          height: height * .085,
          child: ProfileCard(imageUrl: imageUrl),
        ),
        kwidth20,

        //* Username and Date
        Column(
          children: [
            Text(
              'UserName',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            kheight5,
            Text(
              '02/05/2001',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
        const Spacer(),
        //* icon
        const InkWell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.more_horiz,
            ),
          ),
        ),
      ],
    );
  }
}
