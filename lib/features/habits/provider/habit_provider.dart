import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];

  List<Habit> getHabits() {
    return _habits;
  }

  List<Habit> get habits => _habits;

  void addHabit(String title) {
    final uid = Uuid().v4();
    _habits.add(Habit(id: uid, title: title, isDone: false));

    notifyListeners();
  }

  void updateHabit(String newTitle, Habit currentHabit) {
    int currentIndex = _habits.indexOf(currentHabit);

    _habits[currentIndex] = Habit(
        id: currentHabit.id, title: newTitle, isDone: currentHabit.isDone);

    notifyListeners();
  }

  void toggleHabit(Habit currentHabit) {
    int currentIndex = _habits.indexOf(currentHabit);

    _habits[currentIndex] = Habit(
        id: currentHabit.id,
        title: currentHabit.title,
        isDone: !currentHabit.isDone);

    notifyListeners();
  }
}
