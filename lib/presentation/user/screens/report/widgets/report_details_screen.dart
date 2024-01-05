// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pet_care/config/width.dart';
import 'package:pet_care/presentation/user/widgets/cust_text_feild.dart';

ValueNotifier<bool> isUploadImage = ValueNotifier(true);

class ReportDetailsScreen extends StatefulWidget {
  static const String routeName = '/police';

  const ReportDetailsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  // static Route route() {
  final TextEditingController repoCtrl = TextEditingController();
  File? selectedImage;
  CroppedFile? croppedFile;
  final List<String> catagories = [
    'Missing',
    'Adoption',
    'Forage',
  ];

  final ValueNotifier<String> selectedCatagaries =
      ValueNotifier("Select Catagories");

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_outlined,
          ),
        ),
        titleSpacing: .01,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              kheight10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustTextFeild(
                  controller: repoCtrl,
                  hintText: "Explain Breifly What's Reporting",
                  maxLines: 8,
                ),
              ),
              kheight20,

              //* Text form field
              ValueListenableBuilder(
                valueListenable: isUploadImage,
                builder: (context, value, child) {
                  return isUploadImage.value == false
                      ? TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[900],
                            filled: true,
                            hintText: "What's happening?",
                            hintStyle: Theme.of(context).textTheme.displaySmall,
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
                          ? Container(
                              padding: const EdgeInsets.all(15),
                              width: width * .8,
                              decoration: BoxDecoration(
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
                                  Stack(children: [
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
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //* From Gallery
                                InkWell(
                                  onTap: () async {
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

                                //* From Camera
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      getImage(ImageSource.camera);
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

              kheight15,
              InkWell(
                onTap: () {},
                child: Container(
                  width: width * .39,
                  height: height * .059,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Get Location",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
              kheight10,
              //* Submit Button
              InkWell(
                onTap: () {
                  // OpenStreetMapSearchAndPick
                },
                child: Container(
                  width: width * .3,
                  height: height * .059,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
            ],
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
            // ignore: use_build_context_synchronously
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
      if (croppedFile != null) {
        setState(() {
          selectedImage = File(croppedFile!.path);
          log(croppedFile!.path);
        });
        return croppedFile;
      }
    }
  }
}
//* Drop Down List
// SizedBox(
//   width: double.infinity,
//   child: Center(
//     child: ValueListenableBuilder(
//       valueListenable: selectedCatagaries,
//       //Nthappo ante vicharam?
//       builder: (context, value, child) {
//         return DropdownButton(
//           alignment: AlignmentDirectional.center,
//           dropdownColor: Colors.black,
//           hint: Text(
//             selectedCatagaries.value,
//             style: Theme.of(context).textTheme.displayMedium,
//           ),
//           style: Theme.of(context).textTheme.displayMedium,
//           underline: Divider(color: Colors.grey[700]),
//           items: catagories.map((String value) {
//             return DropdownMenuItem(
//               onTap: () {
//                 selectedCatagaries.value = value;
//               },
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: (_) {
//             selectedCatagaries;
//           },
//         );
//       },
//     ),
//   ),
// ),
