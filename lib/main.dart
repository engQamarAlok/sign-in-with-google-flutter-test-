import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_management_app2/core/databases/cache/cache_helper.dart';
import 'package:tasks_management_app2/core/service_locator.dart';
import 'package:tasks_management_app2/firebase_options.dart';
import 'package:tasks_management_app2/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log("Firebase connected successfully! 🎉");
  } catch (e) {
    log("Firebase initialization failed: $e");
  }
  setUpServiceLocator();
  getIt<CacheHelper>().init();
  FlutterError.onError = (details) {
    log("Flutter Error: ${details.exception}");
    log("Location: ${details.stack}");
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks Management',
      theme: ThemeData(
        fontFamily: 'ElMessiri',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 58, 8, 34), // اللون البذرة (العنابي)
          primary: const Color.fromARGB(255, 58, 8, 34), // العنابي (أساسي)
          secondary: const Color(0xFFFFAA00), // البرتقالي (ثانوي)
          tertiary: Color(0xFFD5ECFD), // الأزرق (ثالثي)
          
          surface: Colors.white, // لون الحاويات والأسطح
        ),
        cardColor: Color.fromARGB(255, 238, 248, 255),
        scaffoldBackgroundColor: const Color.fromARGB(255, 58, 8, 34),

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD5ECFD),
          toolbarHeight: 74,
          titleTextStyle: TextStyle(
            fontFamily: 'ElMessiri',
            fontSize: 25,
            color: const Color.fromARGB(255, 58, 8, 34),
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme().apply(fontFamily: 'ElMessiri'),
      ),
      home:SplashScreen(),
    );
  }
}
