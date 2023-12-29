// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/application/bloc/authentication/authentication_bloc.dart';
import 'package:pet_care/application/bloc/sign_up/sign_up_bloc.dart';
import 'package:pet_care/config/app_router.dart';
import 'package:pet_care/config/theme.dart';
import 'package:pet_care/screens/home/home_screen.dart';
import 'package:pet_care/screens/main_screen.dart';

import 'screens/auth/sign_up.dart';

var width;
var height;

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
            return MainScreen();
          } else {
            return BlocProvider(
              create: (context) => SignUpBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const SignUpScreen(),
            );
          }
        },
      ),
    );
  }
}
