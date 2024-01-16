// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/config/config.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../application/bloc/admin/admin_bloc/admin_bloc.dart';
import '../../../../../application/bloc/auth_bloc/my_user/myuser_bloc.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    super.key,
    required this.user,
  });

  final List<String> catagories = [
    'Police',
    'Forest',
    'Veterinary',
    'User',
  ];
  String? role;
  MyUser user;
  final ValueNotifier<String> selectedCatagaries =
      ValueNotifier("Select Catagories");
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: double.infinity,
                  // height: height * .43,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        //?profile
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.transparent,
                                child: user.profilePic == null
                                    ? const Center(
                                        child: Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: user.profilePic ?? '',
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
                                            child: CircularProgressIndicator(
                                              color: Color.fromARGB(
                                                  255, 100, 6, 6),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.person,
                                          size: 50,
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
                              user.name,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            kheight10,
                            Text(
                              user.address.isEmpty ? 'Location' : user.address,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            Text(
                              user.userRole.isEmpty
                                  ? 'User Role'
                                  : user.userRole,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            Text(
                              user.email.isEmpty ? 'Email' : user.email,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            Text(
                              user.phone.toString() == "0"
                                  ? 'Phone'
                                  : user.phone.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            //* Drop Down List
                            SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: selectedCatagaries,
                                  builder: (context, value, child) {
                                    return DropdownButton(
                                      alignment: AlignmentDirectional.center,
                                      dropdownColor: Colors.black,
                                      hint: Text(
                                        selectedCatagaries.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      underline: const Divider(
                                          color: Colors.transparent),
                                      items: catagories.map((String value) {
                                        return DropdownMenuItem(
                                          onTap: () {
                                            selectedCatagaries.value = value;
                                            role = value;
                                          },
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        selectedCatagaries;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Text(
                        //           "Posts",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         ),
                        //         Text(
                        //           state.userPostList.length.toString(),
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         )
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         Text(
                        //           "Reports",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         ),
                        //         Text(
                        //           state.userReportList.length.toString(),
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              kheight10,
              // //* Uplaod Button
              BlocConsumer<MyuserBloc, MyuserState>(
                listener: (context, state) {
                  if (state is UpdateUserDetailsSuccess) {
                    // navigatorKey.currentState!
                    //     .pushReplacement(MaterialPageRoute(
                    //   builder: (context) => ADMainScreen(),
                    // ));
                    navigatorKey.currentState!.pop();

                    context.read<AdminBloc>().add(GetAllData());
                  } else {}
                },
                builder: (context, state) {
                  return SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (role != null) {
                              user = user.copyWith(userRole: role);
                              context
                                  .read<MyuserBloc>()
                                  .add(UpdateUserDetails(user: user));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Choose a Catagory")));
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
                              child: state is UpdateUserDetailsLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Update",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
