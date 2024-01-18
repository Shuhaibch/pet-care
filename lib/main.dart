import 'package:chat_repository/chat_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app.dart';
import 'package:pet_care/firebase_options.dart';
import 'package:pet_care/simple_bloc_observer.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MyApp(
      FirebasePostRepository(),
      FirebaseUserRepository(),
      FirebaseReportRepository(),
      chatRepository: FirebaseChatRepository(),
    ),
  );
}
