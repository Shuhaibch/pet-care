// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/post/post_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import 'application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'application/bloc/auth_bloc/sign_up/sign_up_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final PostRepo postRepo;
  const MyApp(this.postRepo, this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(myUserRository: userRepository),
        ),
        BlocProvider(
            create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository,
                )),
        BlocProvider(
            create: (context) => SignUpBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository,
                )),
        BlocProvider(
          create: (context) => PostBloc(
            postRepo: postRepo,
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
