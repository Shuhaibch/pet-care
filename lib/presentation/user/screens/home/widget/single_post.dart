import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/post/post_bloc.dart';
import 'package:post_repository/post_repository.dart';

import '../../../../../config/config.dart';
import '../../../../../models/allmodel.dart';
import 'widget.dart';

class SinglePost extends StatefulWidget {
  const SinglePost({
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
  State<SinglePost> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  bool isLiked = false;
  List like = [];
  @override
  void initState() {
    super.initState();
    like = widget.post.post.like!;
    isLiked = widget.post.post.like!.contains(user.uid);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      final List likeList =
          widget.post.addLike(userId: widget.post.post.userId);
      final Post newPost = Post(
          userId: widget.post.post.userId,
          postDate: widget.post.post.postDate,
          caption: widget.post.post.caption,
          like: likeList,
          postId: widget.post.post.postId,
          postPic: widget.post.post.postPic);
      context.read<PostBloc>().add(UpdatePost(post: newPost));
    } else {
      final List likeList =
          widget.post.removeLike(userId: widget.post.post.userId);

      final Post newPost = Post(
          userId: widget.post.post.userId,
          postDate: widget.post.post.postDate,
          caption: widget.post.post.caption,
          like: likeList,
          postId: widget.post.post.postId,
          postPic: widget.post.post.postPic);
      context.read<PostBloc>().add(UpdatePost(post: newPost));
    }
  }

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
          ProfileRowInMainCard(
            width: widget.width,
            height: widget.height,
            imageUrl: widget.post.post.postPic!,
            date: widget.formattedDate,
            userName: widget.post.user.name,
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
          Padding(
            padding: const EdgeInsets.only(
              left: 9.0,
              top: 10,
            ),
            child: Row(
              children: [
                LikeButton(
                  isLiked: isLiked,
                  onTap: toggleLike,
                ),
                kwidth10,
                Text(like.length.toString(),
                    style: Theme.of(context).textTheme.displaySmall),
                kwidth20,
                const Icon(Icons.mode_comment_outlined)
              ],
            ),
          )
        ],
      ),
    );
  }
}
