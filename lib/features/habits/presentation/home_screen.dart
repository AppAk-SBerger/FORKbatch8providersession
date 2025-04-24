import 'package:batch8_provider_firestore_24_4/features/authentication/data/firebase_auth_repository.dart';
import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:batch8_provider_firestore_24_4/features/habits/provider/habit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_habit_screen.dart';
import 'edit_habit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _logout() {
    context.read<FirebaseAuthRepository>().logoutUser();
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
      body: Consumer<HabitProvider>(builder: (context, habitprovider, _) {
        return ListView.builder(
          itemCount: habitprovider.habits.length,
          itemBuilder: (_, i) {
            final habit = habitprovider.habits[i];
            return ListTile(
              leading: Checkbox(
                value: habit.isDone,
                onChanged: (val) {
                  habitprovider.toggleHabit(habit);
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
        );
      }),
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
