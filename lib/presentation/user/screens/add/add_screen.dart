import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/presentation/user/widgets/cust_post_textfeild.dart';
import 'package:post_repository/post_repository.dart';
import '../../../../app_view.dart';
import '../../../../application/bloc/post/post_bloc.dart';

ValueNotifier<String> selectedCatagaries = ValueNotifier("Select Catagories");
ValueNotifier<bool> isUploadImage = ValueNotifier(true);

class AddScreen extends StatefulWidget {
  static const String routeName = '/add';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AddScreen(),
    );
  }

  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File? selectedImage;
  CroppedFile? croppedFile;
  bool loading = false;
  final List<String> catagories = [
    'Missing',
    'Adoption',
    'Forage',
  ];
  TextEditingController postCtrl = TextEditingController();

  // String selectedCatagaries = 'Select Catagories';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: SingleChildScrollView(
          child: BlocConsumer<PostBloc, PostState>(
            listener: (context, state) {
              if (state is CreatePostSuccess) {
                setState(() {
                  selectedImage = null;
                  loading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post Success')));
              } else if (state is CreatePostFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Post failed')));
                setState(() {
                  loading = false;
                });
              } else if (state is CreatePostLoading) {
                setState(() {
                  loading = true;
                });
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Post",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  kheight20,

                  // //* Drop Down List
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Center(
                  //     child: ValueListenableBuilder(
                  //         valueListenable: selectedCatagaries,
                  //         //Nthappo ante vicharam?
                  //         builder: (context, value, child) {
                  //           return DropdownButton(
                  //             alignment: AlignmentDirectional.center,
                  //             dropdownColor: Colors.black,
                  //             hint: Text(
                  //               selectedCatagaries.value,
                  //               style: Theme.of(context).textTheme.displayMedium,
                  //             ),
                  //             style: Theme.of(context).textTheme.displayMedium,
                  //             underline: Divider(color: Colors.grey[700]),
                  //             items: catagories.map((String value) {
                  //               return DropdownMenuItem(
                  //                 onTap: () {
                  //                   selectedCatagaries.value = value;
                  //                 },
                  //                 value: value,
                  //                 child: Text(value),
                  //               );
                  //             }).toList(),
                  //             onChanged: (_) {
                  //               selectedCatagaries; //Categaries aathre ayyyyy CategOries aada pothe
                  //             },
                  //           );
                  //         }),
                  //   ),
                  // ),
                  // kheight10,

                  //* Text form field
                  ValueListenableBuilder(
                    valueListenable: isUploadImage,
                    builder: (context, value, child) {
                      return isUploadImage.value == false
                          ? TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.grey[900],
                                filled: true,
                                //Ante show okke malapporth mathi
                                hintText: "What's happening?",
                                hintStyle:
                                    Theme.of(context).textTheme.displaySmall,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.elliptical(
                                      20,
                                      20,
                                    ),
                                  ),
                                  // CircularExterminator
                                ),
                              ),
                              maxLines: 8,
                            )

                          //* Photo Or Video  Button
                          : selectedImage != null
                              ? kwidth10
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        // showBottomSheet(
                                        //   backgroundColor: Colors.transparent,
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return CustomBottomSheet(
                                        //       height: height,
                                        //       width: width,
                                        //     );
                                        //   },
                                        // );
                                        log('mess');
                                        setState(() {
                                          getImage(ImageSource.gallery);
                                        });
                                      },
                                      child: Container(
                                        width: width * .35,
                                        height: height * .20,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius: const BorderRadius.all(
                                            Radius.elliptical(
                                              20,
                                              20,
                                            ),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.browse_gallery_sharp,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          getImage(ImageSource.camera);
                                        });
                                        // showBottomSheet(
                                        //   backgroundColor: Colors.transparent,
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return CustomBottomSheet(
                                        //       height: height,
                                        //       width: width,
                                        //       isVedio: true,
                                        //     );
                                        //   },
                                        // );
                                      },
                                      child: Container(
                                        width: width * .35,
                                        height: height * .20,
                                        decoration: BoxDecoration(
                                          //Ivde vann kalichanda, ith area verenu
                                          color: Colors.grey[900],
                                          borderRadius: const BorderRadius.all(
                                            Radius.elliptical(
                                              20,
                                              20,
                                            ),
                                          ),
                                        ),
                                        // ForHalloween
                                        child: const Center(
                                          child: Icon(
                                            Icons.camera,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                    },
                  ),
                  kheight20,

                  selectedImage != null
                      ? //* Pic preview
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          width: width * .9,
                          decoration: BoxDecoration(
                            //Ivde vann kalichanda, ith area verenu
                            color: Colors.grey[900],

                            borderRadius: const BorderRadius.all(
                              Radius.elliptical(
                                20,
                                20,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8,
                                  bottom: 12,
                                ),
                                child: SizedBox(
                                  width: width * .7,
                                  height: height * .06,
                                  child: CustPostTextFeild(
                                    controller: postCtrl,
                                    hintText: "caption",
                                  ),
                                ),
                              ),
                              selectedImage == null
                                  ? kheight10
                                  : Stack(children: [
                                      Container(
                                        width: width * .68,
                                        height: height * .30,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: FileImage(
                                              selectedImage!,
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
                                              selectedImage = null;
                                            });
                                          },
                                          child: const Icon(Icons.close),
                                        ),
                                      )
                                    ]),
                            ],
                          ),
                        )
                      : const SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //     // isUploadImage.value = !isUploadImage.value;
                              //   },
                              //   child: Center(
                              //     child: ValueListenableBuilder(
                              //         valueListenable: isUploadImage,
                              //         builder: (context, value, child) {
                              //           return Text(
                              //             // isUploadImage.value == false
                              //             "Upload Media",
                              //             // : "Upload text",
                              //             style: Theme.of(context)
                              //                 .textTheme
                              //                 .displaySmall,
                              //           );
                              //         }),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                  // kheight20,

                  kheight20,

                  //* Uplaod Button
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (selectedImage != null) {
                              final post = Post(
                                like: const [],
                                postId: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                userId: user!.uid,
                                postDate: Timestamp.now(),
                                caption: postCtrl.text.isEmpty
                                    ? null
                                    : postCtrl.text,
                              );
                              context.read<PostBloc>().add(CreatePost(
                                  post: post, image: croppedFile!.path));
                            }
                          },
                          child: Container(
                              width: width * .39,
                              height: height * .08,
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(20, 20))),
                              child: Center(
                                child: state is CreatePostLoading
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500, imageQuality: 40);
    if (image != null) {
      croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          selectedImage = File(croppedFile!.path);
          log(croppedFile!.path);
          // context.read<UpdateUserInfoBloc>().add(UploadPicture(
          //     croppedFile.path, context.read<MyUserBloc>().state.user!.id));
        });
        return croppedFile;
      }
    }
  }
}
