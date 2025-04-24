import 'package:batch8_provider_firestore_24_4/features/habits/provider/habit_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'features/authentication/data/firebase_auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Firebase Auth Instanz
  final FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseAuthRepository authRepository =
      FirebaseAuthRepository(authInstance: auth);

  runApp(MultiProvider(providers: [
    Provider<FirebaseAuthRepository>
      (
        create: (_) => authRepository
      ),
      ChangeNotifierProvider(create: (_)=> HabitProvider()),
      

  ],
  child: MyApp(),
  
  
  ));
}
