// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/config/app_router.dart';
import 'package:pet_care/config/theme.dart';
import 'package:pet_care/presentation/user/screens/home/home_screen.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import 'application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import 'application/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import 'presentation/auth/log_in.dart';

var width;
var height;
late User user;

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width;
    height ??= MediaQuery.of(context).size.height;
    return MaterialApp(
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: HomeScreen.routeName,
      theme: them(),
      debugShowCheckedModeBanner: false,
      title: 'Pet Care System',
      navigatorKey: navigatorKey,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            user = state.user!;
            return BlocProvider(
              create: (context) => SignInBloc(
                userRepository:
                    context.read<AuthenticationBloc>().userRepository,
              ),
              child: MainScreen(),
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
