// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/application/bloc/auth_bloc/my_user/myuser_bloc.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'package:pet_care/presentation/user/screens/profile/profile_screen.dart';
import 'package:pet_care/presentation/user/screens/profile/settings/widgets/personal_text_form_feild.dart';


import '../../../../../../app_view.dart';
import '../../../../../../config/config.dart';

class PassWordScreen extends StatefulWidget {
  const PassWordScreen({
    super.key,
  });

  @override
  State<PassWordScreen> createState() => PassWordScreenState();
}

class PassWordScreenState extends State<PassWordScreen> {
  TextEditingController passWordCtrl =
      TextEditingController(text: myUser.name.isEmpty ? null : myUser.name);

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_outlined,
            color: Colors.white,
          ),
        ),
        titleSpacing: .01,
        title: Text(
          "PassWord",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<MyuserBloc, MyuserState>(
        listener: (context, state) {
          if (state is UpdateUserDetailsLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is UpdateUserDetailsError) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Updation Failed")));
          } else if (state is UpdateUserDetailsSuccess) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Updated Successfully")));
            navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Edit Personal Details",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      kheight10,
                      kheight10,
                      PersonalTextFormFeild(
                        controller: passWordCtrl,
                        labelText: "passWord",
                        hintText: "Password",
                      ),
                      kheight10,
                      Container(
                        width: width * .3,
                        height: height * .059,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: const BorderRadius.all(
                            Radius.elliptical(20, 20),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            if (passRexExp.hasMatch(passWordCtrl.text)) {
                              // context.read<MyuserBloc>().add(
                              //     UpdateUserDetails(user: updatedMyUser));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter a valid Password")));
                            }
                          },
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.grey,
                                  )
                                : Text(
                                    "Update",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
