import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/widget/loading_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(FqrcodeApp());
}

class FqrcodeApp extends StatelessWidget {
  FqrcodeApp({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapAuth) {
          if (snapAuth.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          return GetMaterialApp(
            title: "FQR Code",
            initialRoute: snapAuth.hasData ? Routes.home : Routes.login,
            getPages: AppPages.routes,
          );
        });
  }
}
