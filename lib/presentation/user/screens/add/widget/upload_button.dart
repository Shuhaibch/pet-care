import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/bloc/post/post_bloc.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required this.postCtrl,
    required this.selectedImage,
    required this.width,
    required this.height,
  });

  final TextEditingController postCtrl;
  final File? selectedImage;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // final post = Post(
              //   userId: user.uid,
              //   postDate: Timestamp.now(),
              //   caption: postCtrl.text.isEmpty ? null : postCtrl.text,
              //   postPic: selectedImage!.path,
              // );
              // context.read<PostBloc>().add(CreatePost(post: post, image: c));
            },
            child: Container(
              width: width * .39,
              height: height * .08,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(20, 20))),
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is CreatePostLoading) {
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      "Upload",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
