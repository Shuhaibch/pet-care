
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_view.dart';
import '../../../../application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import '../../../../application/bloc/user/user_bloc.dart';
import '../../../auth/log_in.dart';
import '../../../user/screens/profile/widgets/widget.dart';
import 'widgets/office_personalize_screen.dart';

class OfficeProfileSettingsScreen extends StatelessWidget {
  const OfficeProfileSettingsScreen({
    super.key,
  });

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
          "Profile Settings",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () => navigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) =>  BlocProvider.value(
                value: BlocProvider.of<UserBloc>(context),
                child: const OfficePersonalizeScreen(),
              ),
            )),
            child: const ProfileTile(
              subTitle: 'Name, Address',
              title: "Personalize",
              icon: Icons.person,
            ),
          ),
          const ProfileTile(
            subTitle: 'App Details',
            title: "About",
            icon: Icons.smartphone_rounded,
          ),
          InkWell(
            onTap: () {
               context.read<SignInBloc>().add(SignOutRequired());
               navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
            child: BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignOutSuccess) {
                  navigatorKey.currentState?.pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: const ProfileTile(
                subTitle: 'Bye Bye User',
                title: "SignOut",
                icon: Icons.logout_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
