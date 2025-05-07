import 'package:batch8_provider_firestore_24_4/features/habits/data/firestore_habit_repo.dart';
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

  final FirebaseFirestore firestoreInstanz = FirebaseFirestore.instance;

  final FirestoreHabitRepo firestoreHabitRepo =
      FirestoreHabitRepo(firestore: firestoreInstanz, auth: auth);

  FirebaseAuthRepository authRepository =
      FirebaseAuthRepository(authInstance: auth);

  runApp(MultiProvider(
    providers: [
      Provider<FirebaseAuthRepository>(create: (_) => authRepository),
      ChangeNotifierProvider(create: (_) {
        final HabitProvider habitProvider =
            HabitProvider(firestoreHabitRepo: firestoreHabitRepo);
        //    Der Aufruf hier ist "fire-and-forget" (wir warten nicht mit `await` darauf),
        //    weil `create` synchron sein muss. Der Provider selbst kümmert sich
        //    intern darum, seinen Ladezustand (`loading`) zu verwalten und die
        //    UI via `notifyListeners()` zu informieren.
        habitProvider.initialize();
        return habitProvider;
      }),
    ],
    child: MyApp(),
  ));
}
