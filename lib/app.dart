// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:chat_repository/chat_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/auth_bloc/google_auth_bloc/google_auth_bloc.dart';
import 'package:pet_care/application/bloc/post/post_bloc.dart';
import 'package:pet_care/application/bloc/report/report_bloc.dart';
import 'package:pet_care/application/bloc/user/user_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import 'application/bloc/auth_bloc/my_user/myuser_bloc.dart';
import 'application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'application/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import 'application/bloc/chat/chat_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final PostRepo postRepo;
  final ReportRepository reportRepository;
  final ChatRepository chatRepository;
  const MyApp(this.postRepo, this.userRepository, this.reportRepository,
      {super.key, required this.chatRepository});

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
            create: (context) => GoogleAuthBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository,
                )),        
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
            reportRepository: reportRepository,
            postRepo: postRepo,
          ),
        ),
        BlocProvider(
          create: (context) => ReportBloc(
            reportRepository: reportRepository,
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        BlocProvider(
                  create: (context) => ChatBloc(
                    chatRepository:chatRepository ,
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
        BlocProvider(
          create: (context) => PostBloc(
            postRepo: postRepo,
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        BlocProvider(
            create: (context) => MyuserBloc(
                userRepository:
                    context.read<AuthenticationBloc>().userRepository)),
      ],
      child: MyAppView(
        postRepo: postRepo,
        reportRepository: reportRepository,
        chatRepository: chatRepository,
      ),
    );
  }
}
