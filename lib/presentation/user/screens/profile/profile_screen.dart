// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pet_care/presentation/user/screens/profile/widgets/widget.dart';
import 'package:user_repository/user_repository.dart';

import 'package:pet_care/application/bloc/user/user_bloc.dart';
import 'package:pet_care/config/config.dart';

import '../notifier/notifier.dart';

final ValueNotifier<bool> showBottomNotifier = ValueNotifier(false);
File? selectedProfileImage;
CroppedFile? croppedProfileFile;
String? imageUrl;
MyUser myUser = MyUser.empty;

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void dispose() {
    showBottomNotifier.value = false;
    myUser = MyUser.empty;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myUser = MyUser.empty;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UserBloc>(context)
          .add(GetUserData(userId: FirebaseAuth.instance.currentUser!.uid));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      bottomSheet: ValueListenableBuilder(
        valueListenable: showBottomNotifier,
        builder: (context, value, child) {
          return showBottomNotifier.value
              ? const CustomBottomSheet()
              : kheight10;
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocConsumer<UserBloc, UserState>(
            buildWhen: (previous, current) {
              return current is GetUserDataSuccess;
            },
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUserDataSuccess) {
                myUser = MyUser.empty;
                postListNotifier.value = [];
                reportListNotifier.value = [];
                myUser = state.userDetail;
                imageUrl = state.userDetail.profilePic;
                postListNotifier.value = state.userPostList;
                reportListNotifier.value = state.userReportList;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MainProfileTile(
                          height: height,
                          width: width,
                          // postList: _postList,
                          // reportList: _reportList,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is GetUserDataError) {
                return Center(
                  child: Text(
                    "Error Occured",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
