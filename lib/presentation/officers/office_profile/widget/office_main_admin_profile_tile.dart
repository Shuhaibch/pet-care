
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/presentation/officers/office_profile/settings/office_settings_screen.dart';

import '../../../../app_view.dart';
import '../../../../application/bloc/auth_bloc/my_user/myuser_bloc.dart';
import '../../../../application/bloc/user/user_bloc.dart';
import '../../../../config/config.dart';
import '../../../user/widgets/widget.dart';
import '../office_profle_screen.dart';

class MainOfficerProfileTile extends StatelessWidget
    implements PreferredSizeWidget {
  const MainOfficerProfileTile({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

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
                builder: (context) =>  BlocProvider.value(
                 value: BlocProvider.of<UserBloc>(context),
                  child: const OfficeProfileSettingsScreen(),
                ),
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
                        imageUrl: myOfficer.profilePic ?? '',
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
                        showOfficerBottomNotifier.value =
                            !showOfficerBottomNotifier.value;
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
                myOfficer.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white),
              ),
              Text(
                myOfficer.address.isEmpty ? 'Location' : myOfficer.address,
                style: Theme.of(context).textTheme.displaySmall,
              )
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
