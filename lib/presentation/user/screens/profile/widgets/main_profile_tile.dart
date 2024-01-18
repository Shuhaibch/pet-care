// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pet_care/application/bloc/auth_bloc/my_user/myuser_bloc.dart';
import 'package:pet_care/application/bloc/user/user_bloc.dart';
import 'package:pet_care/presentation/user/screens/profile/post/post_tile.dart';
import 'package:pet_care/presentation/user/screens/profile/report/report_tile.dart';
import 'package:pet_care/presentation/user/screens/profile/settings/profile_settings.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../app_view.dart';
import '../../../../../config/config.dart';
import '../../../widgets/widget.dart';
import '../../notifier/notifier.dart';
import '../profile_screen.dart';

class MainProfileTile extends StatelessWidget implements PreferredSizeWidget {
  const MainProfileTile({
    super.key,
    required this.height,
    required this.width, required this.myUser,
    // required this.postList,
    // required this.reportList,
  });

  final double height;
  final double width;
  final MyUser myUser;
  // final List<Post> postList;
  // final List<Report> reportList;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              navigatorKey.currentState?.push(MaterialPageRoute(
                builder: (context) =>  ProfileSettingsScreen(myuser: myUser),
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
                BlocBuilder<MyuserBloc, MyuserState>(
                  builder: (context, state) {
                    if (state is RemoveProfileSuccess) {
                      return const CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ));
                    } else if (state is UpdateUserProfileSuccess) {
                      return CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.transparent,
                        child:
                            CustNetWorkImage(imageUrl: state.user.profilePic),
                      );
                    }
                    return CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.transparent,
                      child: CachedNetworkImage(
                        imageUrl: myUser.profilePic ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        placeholder: (context, url) => const SizedBox(
                          height: 2.0,
                          width: 2.0,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 100, 6, 6),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    );
                  },
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
                        showBottomNotifier.value = !showBottomNotifier.value;
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
                myUser.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              ),
              kheight10,
              Text(
                myUser.address.isEmpty ? 'Location' : myUser.address,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              kheight10,
              Text(
                myUser.phone == 0 ? 'Phone' : myUser.phone.toString(),
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          ),
          kheight10,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ValueListenableBuilder(
                  valueListenable: postListNotifier,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () =>
                          navigatorKey.currentState!.push(MaterialPageRoute(
                        builder: (context) => PostTile(
                          myUser: myUser,
                          title: "Posts",
                          post: postListNotifier.value,
                        ),
                      )),
                      child: Column(
                        children: [
                          Text(
                            "Posts",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            value.length.toString(),
                            style: Theme.of(context).textTheme.displayMedium,
                          )
                        ],
                      ),
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: reportListNotifier,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () =>
                          navigatorKey.currentState!.push(MaterialPageRoute(
                        builder: (context) => ReportTile(
                          myUser: myUser,
                          title: "Reports",
                          report: reportListNotifier.value,
                        ),
                      )),
                      child: Column(
                        children: [
                          Text(
                            "Reports",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            value.length.toString(),
                            style: Theme.of(context).textTheme.displayMedium,
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
