import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/user/user_bloc.dart';
import 'package:pet_care/presentation/user/screens/home/home_screen.dart';
import 'package:pet_care/presentation/user/screens/notifier/notifier.dart';
import 'package:pet_care/presentation/user/widgets/widget.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../../config/config.dart';
import '../../../home/widget/widget.dart';

class SinglePostScreen extends StatefulWidget {
  const SinglePostScreen({
    super.key,
    required this.post,
    required this.myuser,
  });

  final Post post;
  final MyUser myuser;

  @override
  State<SinglePostScreen> createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePostScreen> {
  bool isLiked = false;
  List like = [];
  String? formattedDate;

  @override
  void initState() {
    super.initState();
    like = widget.post.like!;
    isLiked = widget.post.like!.contains(user!.uid);
    formattedDate = formateDate(widget.post.postDate);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      List likeList = widget.post.addLike(userId: widget.post.userId);
      final Post newPost = Post(
          userId: widget.post.userId,
          postDate: widget.post.postDate,
          caption: widget.post.caption,
          like: likeList,
          postId: widget.post.postId,
          postPic: widget.post.postPic);
      context.read<UserBloc>().add(UpdatePost(post: newPost));
    } else {
      List likeList = widget.post.removeLike(userId: widget.post.userId);

      final Post newPost = Post(
          userId: widget.post.userId,
          postDate: widget.post.postDate,
          caption: widget.post.caption,
          like: likeList,
          postId: widget.post.postId,
          postPic: widget.post.postPic);
      context.read<UserBloc>().add(UpdatePost(post: newPost));
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = formateDate(widget.post.postDate);

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                width: width,
                height: height,
                imageUrl: widget.myuser.profilePic!,
                date: formattedDate,
                userName: widget.myuser.name,
              ),
              kheight10,

              //* Main Picture
              Container(
                  width: width * .8,
                  height: height * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CustNetWorkImage(imageUrl: widget.post.postPic)),
              widget.post.caption == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Row(
                        children: [
                          Text(
                            widget.post.caption ?? '',
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
                    // const Icon(Icons.mode_comment_outlined)
                  ],
                ),
              ),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is DeletePostError) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Delete failed"),
                    ));
                  } else if (state is DeletePostSuccess) {
                    final myList = postListNotifier.value
                        .where((item) => item != widget.post)
                        .toList();

                    postListNotifier.value = myList;
                    navigatorKey.currentState!.pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Delete Success"),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is DeletePostLoading) {
                    return const LoadingButton();
                  }
                  return InkWell(
                    onTap: () => context
                        .read<UserBloc>()
                        .add(DeletePost(post: widget.post.postId!)),
                    child: const CustButton(title: "Delete"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
