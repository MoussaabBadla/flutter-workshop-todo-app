class Todo {
 final  int? id;
  final String title;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.isCompleted,
  });

  
  Map<String, Object?> toMap() {
    return {"id": id, "title": title, "isCompleted": isCompleted ? 1 : 0};
  }

  factory Todo.fromMap(Map<String, Object?> map) {
    return Todo(
        id: map['id'] as int,
        title: map['title'] as String,
        isCompleted: map['isCompleted'] == 1);
  }
}
