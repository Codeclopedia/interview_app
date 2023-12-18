import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/providers/changes_provider.dart';
import 'package:flutter_application_1/screens/auth_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'network/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return MaterialApp(
        title: 'Flutter Firebase Auth Demo',
        themeMode:
            ref.watch(isNightThemeProvider) ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData.dark(),
        home: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userProvider);

            // Check if the user is logged in
            return user != null ? const HomeScreen() : const AuthScreen();
          },
        ),
      );
    });
  }
}
