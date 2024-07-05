import 'package:firebase/screen/notification/api/firebase_api_calss.dart';
import 'package:firebase/screen/notification/api/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase/screen/auth/first_screen.dart';
// import 'package:firebase/screen/check_users.dart';
import "package:firebase/screen/auth//check_users.dart";

final navigatorKey=GlobalKey<NavigatorState>();
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await  FirebaseApiClass().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,

      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      title: 'LogInScreen',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirstScreenButton(),

    );
  }
}
