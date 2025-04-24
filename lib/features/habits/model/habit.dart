class Habit {
  final String id;
  final String title;
  final bool isDone;

  Habit({
    required this.id,
    required this.title,
    required this.isDone,
  });

  factory Habit.fromMap(Map<String, dynamic> map, String id) {
    return Habit(
      id: id,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

}
