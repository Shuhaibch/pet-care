import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/config/theme.dart';
import 'package:pet_care/firebase_options.dart';
import 'package:pet_care/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // onGenerateRoute: AppRoute.onGenerateRoute,
      // initialRoute: HomeScreen.routeName,
      theme: them(),
      debugShowCheckedModeBanner: false,
      title: 'Pet Care System',
      home: MainScreen(),
    );
  }
}
