import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'package:pet_care/presentation/auth/log_in.dart';
import 'package:pet_care/presentation/user/screens/profile/widgets/settings/widgets/personalize.dart';
import 'package:pet_care/presentation/user/screens/profile/widgets/tile.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({
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
              builder: (context) => const PersonalizeScreen(),
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
              navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));

              context.read<SignInBloc>().add(SignOutRequired());
            },
            child: BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignOutSuccess) {
                  navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
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
