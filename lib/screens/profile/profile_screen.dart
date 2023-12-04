import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/screens/profile/widgets/custom_bottom_sheet.dart';
import 'widgets/tile.dart';

final ValueNotifier<bool> showBottomNotifier = ValueNotifier(false);

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfileScreen(),
    );
  }

  const ProfileScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                    Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.settings),
                      ),
                    ),

                    //?profile
                    Container(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          const CircleAvatar(
                            radius: 55,
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
                                  showBottomNotifier.value =
                                      !showBottomNotifier.value;
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
                          "UserName",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text('Location',
                            style: Theme.of(context).textTheme.displaySmall)
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
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text("25",
                                style:
                                    Theme.of(context).textTheme.displayMedium)
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Reports",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Text(
                              "25",
                              style: Theme.of(context).textTheme.displayMedium,
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

            Expanded(
              child: ListView(
                children: const [
                  ProfileTile(
                    subTitle: 'Name, Address',
                    title: "Personalize",
                    icon: Icons.person,
                  ),
                  ProfileTile(
                    subTitle: 'Name, Address',
                    title: "Personalize",
                    icon: Icons.person,
                  ),
                  ProfileTile(
                    subTitle: 'Name, Address',
                    title: "Personalize",
                    icon: Icons.person,
                  ),
                  ProfileTile(
                    subTitle: 'Name, Address',
                    title: "Personalize",
                    icon: Icons.person,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
