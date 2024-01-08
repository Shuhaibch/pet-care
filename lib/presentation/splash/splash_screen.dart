import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/application/bloc/admin/admin_bloc/admin_bloc.dart';
import 'package:pet_care/application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import 'package:pet_care/presentation/admin/ad_main_screens.dart';
import 'package:pet_care/presentation/officers/veterinary/veterinary_home_screen.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';

import '../../application/bloc/auth_bloc/my_user_bloc/my_users_bloc.dart';

class SplashScreen extends StatelessWidget {
  final ReportRepository reportRepository = FirebaseReportRepository();
  final PostRepo postRepo = FirebasePostRepository();
  SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyUsersBloc, MyUsersState>(builder: (context, state) {
      if (state.status == MyUsersStatus.success) {
        if (state.users!.userRole == 'Admin') {
          return BlocProvider(
            create: (context) => AdminBloc(
              postRepo: postRepo,
              reportRepository: reportRepository,
              userRepository: context.read<AuthenticationBloc>().userRepository,
            ),
            child: ADMainScreen(),
          );
        } else if (state.users!.userRole == 'User') {
          return MainScreen();
        } else {
          return const VeterinaryHomeScreen(title: "title");
        }
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
