import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pet_care/presentation/admin/screens/ad_profile/widget/ad_cust_bottom_sheet.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../app_view.dart';
import '../../../../application/bloc/user/user_bloc.dart';
import '../../../../config/config.dart';
import 'widget/ad_main_admin_profile_tile.dart';

MyUser myAdmin = MyUser.empty;

final ValueNotifier<bool> showAdminBottomNotifier = ValueNotifier(false);
File? selectedAdminProfileImage;
CroppedFile? croppedAdminProfileFile;
String? imageUrl;

class ADProfileScreen extends StatefulWidget {
  const ADProfileScreen({super.key});

  @override
  State<ADProfileScreen> createState() => _ADProfileScreenState();
}

class _ADProfileScreenState extends State<ADProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UserBloc>(context)
          .add(GetUserData(userId: FirebaseAuth.instance.currentUser!.uid));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      bottomSheet: ValueListenableBuilder(
        valueListenable: showAdminBottomNotifier,
        builder: (context, value, child) {
          return showAdminBottomNotifier.value
              ? const AdminCustomBottomSheet()
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
                myAdmin = state.userDetail;
                log(myAdmin.toString());
                imageUrl = state.userDetail.profilePic;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MainAdminProfileTile(
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
