import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/presentation/user/screens/home/widget/profile_row.dart';

import '../../../../../application/bloc/post/post_bloc.dart';
import '../../../../../config/config.dart';
import '../../../../../models/all_post.dart';

class ADSinglePost extends StatefulWidget {
  const ADSinglePost({
    super.key,
    required this.height,
    required this.width,
    required this.post,
    required this.formattedDate,
  });

  final double height;
  final double width;
  final AllPost post;
  final String formattedDate;

  @override
  State<ADSinglePost> createState() => _ADSinglePostState();
}

class _ADSinglePostState extends State<ADSinglePost> {
  // bool isLiked = false;
  // List like = [];
  @override
  // void initState() {
  //   super.initState();
  //   like = widget.post.post.like!;
  //   isLiked = widget.post.post.like!.contains(user!.uid);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // height: widget.height * .45,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.25),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          //* profile with name and photo
          BlocListener<PostBloc, PostState>(
            listener: (context, state) {
              if (state is DeletePostSuccess) {
                context.read<PostBloc>().add(GetAllPost());
              }
            },
            child: ProfileRowInMainCard(
              width: widget.width,
              height: widget.height,
              imageUrl: widget.post.user.profilePic!,
              date: widget.formattedDate,
              userName: widget.post.user.name,
              isAdmin: true,
              onTap: () {
                log('tapp');
                context
                    .read<PostBloc>()
                    .add(DeletePost(postId: widget.post.post.postId!));
              },
            ),
          ),
          kheight10,

          //* Main Picture
          Container(
            width: widget.width * .8,
            height: widget.height * .23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.post.post.postPic!,
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
          widget.post.post.caption == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Row(
                    children: [
                      Text(
                        widget.post.post.caption ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),

          //* Icons
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 9.0,
          //     top: 10,
          //   ),
          //   child: Row(
          //     children: [
          //       // LikeButton(
          //       //   isLiked: isLiked,
          //       //   onTap: toggleLike,
          //       // ),
          //       // kwidth10,
          //       // Text(like.length.toString(),
          //       //     style: Theme.of(context).textTheme.displaySmall),
          //       // kwidth20,
          //       // const Icon(Icons.mode_comment_outlined)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
