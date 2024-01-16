import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pet_care/presentation/officers/office_profile/widget/office_main_admin_profile_tile.dart';
import 'package:user_repository/user_repository.dart';

import '../../../app_view.dart';
import '../../../application/bloc/user/user_bloc.dart';
import '../../../config/config.dart';
import 'widget/office_cust_bottom_sheet.dart';

MyUser myOfficer = MyUser.empty;
final ValueNotifier<bool> showOfficerBottomNotifier = ValueNotifier(false);
File? selectedOfficerProfileImage;
CroppedFile? croppedOfficerProfileFile;
String? imageUrl;

class OfficerProfileScreen extends StatefulWidget {
  const OfficerProfileScreen({super.key});

  @override
  State<OfficerProfileScreen> createState() => _OfficerProfileScreenState();
}

class _OfficerProfileScreenState extends State<OfficerProfileScreen> {
  @override
  void initState() {
    super.initState();
    myOfficer = MyUser.empty;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UserBloc>(context).add(GetUserData(userId: FirebaseAuth.instance.currentUser!.uid));
    });
  }

  @override
  void dispose() {
    myOfficer = MyUser.empty;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      bottomSheet: ValueListenableBuilder(
        valueListenable: showOfficerBottomNotifier,
        builder: (context, value, child) {
          return showOfficerBottomNotifier.value
              ? const OfficerCustomBottomSheet()
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
                myOfficer = MyUser.empty;
                myOfficer = state.userDetail;
                log(myOfficer.toString());
                imageUrl = state.userDetail.profilePic;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: MainOfficerProfileTile(
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
