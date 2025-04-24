import 'package:batch8_provider_firestore_24_4/features/habits/provider/habit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gewohnheit hinzufügen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Titel'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final title = _controller.text.trim();
              if (title.isEmpty) return;

              context.read<HabitProvider>().addHabit(title);

              Navigator.of(context).pop();
            },
            child: const Text('Speichern'),
          )
        ]),
      ),
    );
  }
}
