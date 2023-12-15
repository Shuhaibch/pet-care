import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/config/app_router.dart';
import 'package:pet_care/config/theme.dart';
import 'package:pet_care/firebase_options.dart';
import 'package:pet_care/screens/auth/sign_up.dart';
import 'package:pet_care/screens/home/home_screen.dart';
import 'package:pet_care/screens/main_screen.dart';
import 'package:pet_care/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: HomeScreen.routeName,
      theme: them(),
      debugShowCheckedModeBanner: false,
      title: 'Pet Care System',
      navigatorKey: navigatorKey,
      home: SignUpScreen(),
    );
  }
}
