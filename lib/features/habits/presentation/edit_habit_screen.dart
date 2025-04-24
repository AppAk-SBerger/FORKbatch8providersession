import 'package:batch8_provider_firestore_24_4/features/habits/model/habit.dart';
import 'package:batch8_provider_firestore_24_4/features/habits/provider/habit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditHabitScreen extends StatefulWidget {
  final Habit currentHabit;

  const EditHabitScreen({super.key, required this.currentHabit});

  @override
  State<EditHabitScreen> createState() => _EditHabitScreenState();
}

class _EditHabitScreenState extends State<EditHabitScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.currentHabit.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gewohnheit bearbeiten')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Titel'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final updatedTitle = _controller.text.trim();
              if (updatedTitle.isEmpty) return;

              context
                  .read<HabitProvider>()
                  .updateHabit(updatedTitle, widget.currentHabit);

              Navigator.of(context).pop();
            },
            child: const Text('Speichern'),
          )
        ]),
      ),
    );
  }
}
