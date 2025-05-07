import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHabitRepo {
  final FirebaseFirestore firestore;

  final FirebaseAuth auth;

  FirestoreHabitRepo({required this.firestore, required this.auth});

  String get _uid {
    final user = auth.currentUser;
    if (user == null) throw Exception("User not logged in");
    return user.uid;
  }

  Future<List<Habit>> getHabits() async {
    final snapshot = await firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .get();
    return snapshot.docs
        .map((doc) => Habit.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addHabit(Habit habit) async {
    await firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .doc(habit.id)
        .set(habit.toMap());
  }

  Future<void> updateHabit(Habit habit, String newTitle) async {
    await firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .doc(habit.id)
        .update({'title': newTitle});
  }
  Future<void> toggleHabit(Habit habit, bool isDone) async {
    await firestore
        .collection("users")
        .doc(_uid)
        .collection("habits")
        .doc(habit.id)
        .update({'isDone': isDone});
  }
}
