// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';

import 'package:pet_care/application/bloc/auth_bloc/my_user_bloc/my_users_bloc.dart';
import 'package:pet_care/application/bloc/chat/chat_bloc.dart';
import 'package:pet_care/config/theme.dart';
import 'package:pet_care/presentation/splash/splash_screen.dart';

import 'application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import 'application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'application/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import 'presentation/auth/log_in.dart';

var width;
var height;
User? user;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyAppView extends StatelessWidget {
  const MyAppView({
    super.key,
    required this.postRepo,
    required this.reportRepository,
    required this.chatRepository,
  });
  final PostRepo postRepo;
  final ReportRepository reportRepository;
  final ChatRepository chatRepository;
  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width;
    height ??= MediaQuery.of(context).size.height;
    return MaterialApp(
      // onGenerateRoute: AppRoute.onGenerateRoute,
      // initialRoute: HomeScreen.routeName,
      theme: them(),
      debugShowCheckedModeBanner: false,
      title: 'Pet Care System',
      navigatorKey: navigatorKey,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            user = FirebaseAuth.instance.currentUser!;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                 
                
                // BlocProvider(
                //   create: (context) => MyUsersBloc(
                //     userRepository:
                //         context.read<AuthenticationBloc>().userRepository,
                //   )..add(
                //       GetMyUsers(
                //         myUsersId: context
                //             .read<AuthenticationBloc>()
                //             .state
                //             .user!
                //             .uid,
                //       ),
                //     ),
                // ),
              ],
              child: BlocProvider(
                create: (context) => MyUsersBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository,
                )..add(
                    GetMyUsers(
                      myUsersId:
                          context.read<AuthenticationBloc>().state.user!.uid,
                    ),
                  ),
                child: SplashScreen(),
              ),
            );
          } else {
            return BlocProvider(
              create: (context) => SignUpBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const LoginScreen(),
            );
          }
        },
      ),
    );
  }
}
