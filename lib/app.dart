import 'package:batch8_provider_firestore_24_4/features/authentication/presentation/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'features/authentication/data/firebase_auth_repository.dart';
import 'features/habits/presentation/home_screen.dart';

class MyApp extends StatelessWidget {
  final FirebaseAuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authRepository.onAuthStateChanged,
        builder: (context, snapshot) {
          // Es reicht zu überprüfen, ob wir einen User haben
          final isLoggedIn = snapshot.data != null;
          return MaterialApp(
              key: isLoggedIn ? Key("logged_in") : Key("not_logged_in"),
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: isLoggedIn ? HomeScreen() : LogInPage());
        });
  }
}
