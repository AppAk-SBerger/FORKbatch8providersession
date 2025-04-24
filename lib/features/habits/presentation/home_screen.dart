import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:flutter/material.dart';
import 'add_habit_screen.dart';
import 'edit_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Habit> habits = [];

  void _logout() {
    //TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meine Gewohnheiten'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (_, i) {
          final habit = habits[i];
          return ListTile(
            leading: Checkbox(
              value: habit.isDone,
              onChanged: (val) {
                //TODO
              },
            ),
            title: Text(
              habit.title,
              style: TextStyle(
                decoration: habit.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditHabitScreen(
                      currentHabit: habit,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddHabitScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
