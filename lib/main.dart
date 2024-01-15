import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_besar1/constants/theme.dart';
import 'package:tugas_besar1/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:tugas_besar1/provider/app_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tugas_besar1/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:tugas_besar1/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sandhika Shop',
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomBottomBar();
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
