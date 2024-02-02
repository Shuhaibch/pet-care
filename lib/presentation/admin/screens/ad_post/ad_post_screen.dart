import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/models/all_post.dart';

import '../../../../application/bloc/post/post_bloc.dart';
import '../../../user/screens/home/widget/widget.dart';
import 'widget/ad_post_screen.dart';

class ADPostScreen extends StatelessWidget {
  const ADPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PostBloc>(context).add(GetAllPost());
    });

    return Column(
      children: [
        Expanded(
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {},
            // buildWhen: (previous, current) => current is GetAllPostSuccess,
            builder: (context, state) {
              if (state is GetAllPostSuccess) {
                return state.allPost.isEmpty
                    ? Center(
                        child: Text('List is Empty',
                            style: Theme.of(context).textTheme.displayMedium!
                            // .copyWith(color: Colors.white),
                            ),
                      )
                    : ListView.separated(
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
                            post.post.postDate.seconds,
                            post.post.postDate.nanoseconds,
                          );

                          DateTime dateTime =
                              DateTime.fromMillisecondsSinceEpoch(
                            timestamp.seconds * 1000 +
                                (timestamp.nanoseconds / 1000000).round(),
                            isUtc: true,
                          );
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(dateTime);

                          //* Single Post Container
                          return ADSinglePost(
                              height: height,
                              width: width,
                              post: post,
                              formattedDate: formattedDate);
                        },
                      );
              } else if (state is GetAllPostFailed) {
                return const Center(
                  child: Text('Error'),
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.grey,
              ));
            },
          ),
        ),
      ],
    );
  }
}
