import 'dart:convert';

List<TodoModel> todoModelFromJson(List<dynamic> str) =>
    List<TodoModel>.from(str.map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  TodoModel({
    this.id,
    this.todoTitle,
    this.todoDescription,
    this.todoDate,
    this.isCompleted,
  });

  final int? id;
  final String? todoTitle;
  final String? todoDescription;
  final DateTime? todoDate;
  final bool? isCompleted;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        todoTitle: json["todo_title"],
        todoDescription: json["todo_description"],
        todoDate: DateTime.parse(json["todo_date"]),
        isCompleted: json["is_completed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo_title": todoTitle,
        "todo_description": todoDescription,
        "todo_date": todoDate.toString(),
        "is_completed": isCompleted,
      };
}
