import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/application/bloc/auth_bloc/my_user/myuser_bloc.dart';
import 'package:pet_care/config/config.dart';

import '../../../../../app_view.dart';
import '../../screen.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
  });
  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyuserBloc, MyuserState>(
      listener: (context, state) {
        if (state is UpdateUserProfileSuccess) {
          
          showBottomNotifier.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile Updated Successfully')));

        } else {}
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.horizontal_rule_sharp),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Profile Photo",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Spacer(),
                      InkWell(
                        child: const Icon(Icons.close),
                        onTap: () {
                          showBottomNotifier.value = !showBottomNotifier.value;
                        },
                      )
                    ],
                  ),
                ),
                selectedProfileImage != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          Container(
                            width: width * .68,
                            height: height * .30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(
                                  selectedProfileImage!,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 1,
                            right: 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedProfileImage = null;
                                });
                              },
                              child: const Icon(Icons.close),
                            ),
                          )
                        ]),
                      )
                    : const SizedBox(),
                kheight10,
                selectedProfileImage != null
                    ? //* Uplaod Button
                    SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (selectedProfileImage != null) { 
                                  myUser = myUser.copyWith(
                                      profilePic: selectedProfileImage!.path);
                                  context
                                      .read<MyuserBloc>()
                                      .add(UpdateUserProfile(user: myUser));
                                }
                              },
                              child: Container(
                                  width: width * .39,
                                  height: height * .08,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(20, 20))),
                                  child: Center(
                                    child: state is UpdateUserProfileLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.grey,
                                          )
                                        : Text(
                                            "Upload",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      getImage(ImageSource.gallery, context);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(Icons.photo),
                                    ),
                                  ),
                                  kheight10,
                                  Text(
                                    "Gallery",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  getImage(ImageSource.camera, context);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child:
                                          const Icon(Icons.camera_alt_outlined),
                                    ),
                                    kheight10,
                                    Text(
                                      "Camera",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: const Icon(Icons.delete),
                                    ),
                                    kheight10,
                                    Text(
                                      "Remove",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future getImage(ImageSource source, BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500, imageQuality: 40);
    if (image != null) {
      croppedProfileFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedProfileFile != null) {
        setState(() {
          selectedProfileImage = File(croppedProfileFile!.path);
          log(croppedProfileFile!.path);
        });
        return croppedProfileFile;
      }
    }
  }
}
