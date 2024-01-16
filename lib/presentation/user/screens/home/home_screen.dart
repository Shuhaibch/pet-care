import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/application/bloc/post/post_bloc.dart';
import 'package:pet_care/models/all_post.dart';
import '../../widgets/widget.dart';
import 'widget/widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetAllPost());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      //* App Bar
      appBar: CustomAppBar(
        height: height,
        title: 'Feed',
      ),

      body: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetAllPostSuccess) {
            return
                // state.allPost.isEmpty
                //     ? Center(
                //         child: Text(
                //           'List is Empty',
                //           style: Theme.of(context)
                //               .textTheme
                //               .displayMedium!
                //               .copyWith(color: Colors.white),
                //         ),
                //       )
                //     :
                ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: state.allPost.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                final AllPost post = state.allPost[index];
                // log(post.post.postPic.toString());
                // print(post);
                Timestamp timestamp = Timestamp(
                    post.post.postDate.seconds, post.post.postDate.nanoseconds);

                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                  timestamp.seconds * 1000 +
                      (timestamp.nanoseconds / 1000000).round(),
                  isUtc: true,
                );
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(dateTime);

                //* Single Post Container
                return SinglePost(
                    height: height,
                    width: width,
                    post: post,
                    formattedDate: formattedDate);
              },
            );
          } else if (state is GetAllPostFailed) {
            return Center(
              child: Text(
                'Error',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.grey,
          ));
        },
      ),
    );
  }
}

String formateDate(Timestamp time) {
  Timestamp timestamp = Timestamp(time.seconds, time.nanoseconds);

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
    timestamp.seconds * 1000 + (timestamp.nanoseconds / 1000000).round(),
    isUtc: true,
  );
  String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
  return formattedDate;
}
