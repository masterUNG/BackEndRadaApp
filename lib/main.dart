import 'dart:io';

import 'package:backendradaapp/state/main_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride();

  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyD0pFlJj_jXsJYtXzODhOIJTA7oMTyb3C0',
              appId: '1:78506071953:web:6ab548bac2d729286fec30',
              messagingSenderId: '78506071953',
              projectId: 'radaapp-3db83'))
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MainHome(),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
