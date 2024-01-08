// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pet_care/application/bloc/user/user_bloc.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/presentation/admin/screens/ad_profile/widgets/custom_ad_bottom_sheet.dart';
import 'package:pet_care/presentation/admin/screens/ad_profile/widgets/settings/ad_profile_settings.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'package:user_repository/user_repository.dart';
import '../../../../../app_view.dart';

MyUser myAdmin = MyUser.empty;
final ValueNotifier<bool> adshowBottomNotifier = ValueNotifier(false);
File? selectedADProfileImage;
CroppedFile? croppedADProfileFile;

class ADProfileScreen extends StatefulWidget {
  // static const String routeName = '/profile';
  // static Route route() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (_) =>  ADProfileScreen(),
  //   );
  // }

  const ADProfileScreen({super.key});

  @override
  State<ADProfileScreen> createState() => _ADProfileScreenState();
}

class _ADProfileScreenState extends State<ADProfileScreen> {
  @override
  void dispose() {
    adshowBottomNotifier.value = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UserBloc>(context).add(GetUserData(userId: user!.uid));
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
        valueListenable: adshowBottomNotifier,
        builder: (context, value, child) {
          return adshowBottomNotifier.value
              ? const CustomADBottomSheet()
              : kheight10;
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUserDataSuccess) {
                myAdmin = state.userDetail;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: double.infinity,
                        height: height * .43,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: const BorderRadius.all(
                            Radius.elliptical(20, 20),
                          ),
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                navigatorKey.currentState
                                    ?.push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ADProfileSettingsScreen(),
                                ));
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: double.infinity,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.settings),
                                ),
                              ),
                            ),

                            //?profile
                            Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.transparent,
                                    child: myAdmin.profilePic == null
                                        ? const Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                state.userDetail.profilePic!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const SizedBox(
                                              height: 2.0,
                                              width: 2.0,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 100, 6, 6),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error,
                                              size: 50,
                                            ),
                                          ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          adshowBottomNotifier.value =
                                              !adshowBottomNotifier.value;
                                          // showBottomSheet(
                                          //   backgroundColor: Colors.transparent,
                                          //   context: context,
                                          //   builder: (context) {
                                          //     return const CustomBottomSheet();
                                          //     // Container(
                                          //     //   alignment: Alignment.topCenter,
                                          //     //   height: 220,
                                          //     //   width: double.infinity,
                                          //     //   decoration: BoxDecoration(
                                          //     //     color: Colors.grey[900],
                                          //     //     borderRadius: const BorderRadius.only(
                                          //     //       topLeft: Radius.elliptical(20, 20),
                                          //     //       topRight: Radius.elliptical(20, 20),
                                          //     //     ),
                                          //     //   ),
                                          //     //   child: ChangeProfileIconRow(
                                          //     //     icon: Icons.photo,
                                          //     //     title: "Gallery",
                                          //     //     width: width,
                                          //     //     height: height,
                                          //     //   ),
                                          //     // );
                                          //   },
                                          // );
                                        },
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            kheight10,
                            Column(
                              children: [
                                Text(
                                  myAdmin.name,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                Text(
                                  myAdmin.address.isEmpty
                                      ? 'Location'
                                      : myAdmin.address,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              ],
                            ),
                            //* Uplaod Button
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: width * .39,
                                      height: height * .08,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius: const BorderRadius.all(
                                              Radius.elliptical(20, 20))),
                                      child: Center(
                                        child: Text(
                                          "Report",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Posts",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      state.userPostList.length.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Reports",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    Text(
                                      state.userReportList.length.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    //?
                  ],
                );
              } else if (state is GetUserDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
              return Center(
                child: Text(
                  "Error Occured",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
