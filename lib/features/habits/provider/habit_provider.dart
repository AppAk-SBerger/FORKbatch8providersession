import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../data/firestore_habit_repo.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];

  bool isLoading = false;

  final FirestoreHabitRepo firestoreHabitRepo;

  HabitProvider({required this.firestoreHabitRepo});

  Future<void> initialize() async {
    isLoading = true;

    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    _habits = await firestoreHabitRepo.getHabits();

    isLoading = false;

    notifyListeners();
  }

  List<Habit> getHabits() {
    return _habits;
  }

  List<Habit> get habits => _habits;

  void addHabit(String title) async {
    final id = Uuid().v4();

    Habit newHabit = Habit(id: id, title: title, isDone: false);
    _habits.add(newHabit);

    await firestoreHabitRepo.addHabit(newHabit);

    notifyListeners();
  }

  void updateHabit(String newTitle, Habit currentHabit) async {
    await firestoreHabitRepo.updateHabit(currentHabit, newTitle);

    int currentIndex = _habits.indexOf(currentHabit);

    _habits[currentIndex] = Habit(
        id: currentHabit.id, title: newTitle, isDone: currentHabit.isDone);

    notifyListeners();
  }

  void toggleHabit(Habit currentHabit) async {
    await firestoreHabitRepo.toggleHabit(currentHabit, !currentHabit.isDone);

    int currentIndex = _habits.indexOf(currentHabit);

    _habits[currentIndex] = Habit(
        id: currentHabit.id,
        title: currentHabit.title,
        isDone: !currentHabit.isDone);

    notifyListeners();
  }
}
