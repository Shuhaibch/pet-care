import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../../app_view.dart';
import '../../../../../application/bloc/auth_bloc/my_user/myuser_bloc.dart';
import '../../../../../application/bloc/user/user_bloc.dart';
import '../../../../../config/config.dart';
import '../../../../user/screens/profile/settings/widgets/widget.dart';
import '../../office_profle_screen.dart';

class OfficePersonalizeScreen extends StatefulWidget {
  const OfficePersonalizeScreen({
    super.key,
  });

  @override
  State<OfficePersonalizeScreen> createState() =>
      _OfficePersonalizeScreenState();
}

class _OfficePersonalizeScreenState extends State<OfficePersonalizeScreen> {
  TextEditingController nameCtrl = TextEditingController(
      text: myOfficer.name.isEmpty ? null : myOfficer.name);

  TextEditingController addressCtrl = TextEditingController(
      text: myOfficer.address.isEmpty ? null : myOfficer.address);

  TextEditingController phoneCtrl = TextEditingController(
    text: myOfficer.phone == 0 ? null : myOfficer.phone.toString(),
  );
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
          "Persinalize",
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
            BlocProvider.of<UserBloc>(context)
                .add(GetUserData(userId: user!.uid));
            navigatorKey.currentState!.pop();
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
                      PersonalTextFormFeild(
                        controller: nameCtrl,
                        hintText: "User Name",
                        labelText: "User Name",
                      ),
                      kheight10,
                      PersonalTextFormFeild(
                        controller: addressCtrl,
                        labelText: "Address",
                        hintText: "Address",
                      ),
                      kheight10,
                      PersonalTextFormFeild(
                        controller: phoneCtrl,
                        labelText: "Phone",
                        hintText: "Phone",
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
                            if (nameCtrl.text.isNotEmpty ||
                                addressCtrl.text.isNotEmpty) {
                              if (phoneRexExp.hasMatch(phoneCtrl.text)) {
                                final MyUser updatedMyOfficer =
                                    myOfficer.copyWith(
                                        address: addressCtrl.text,
                                        name: nameCtrl.text,
                                        phone: int.parse(phoneCtrl.text));
                                context.read<MyuserBloc>().add(
                                    UpdateUserDetails(user: updatedMyOfficer));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Enter a Valid Phone Number")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Address or name is empty")));
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
