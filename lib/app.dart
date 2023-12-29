// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/authentication/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';


class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {

    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: const MyAppView(),
    );
  }
}
