import 'package:flutter/material.dart'; // Add this import for Colors and Icons

enum TaskPriority { low, medium, high }

class Task {
  String id;
  String title;
  String? description;
  bool isCompleted;
  DateTime createdAt;
  DateTime? dueDate;
  TaskPriority priority;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    DateTime? createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
  }) : createdAt = createdAt ?? DateTime.now();

  // Toggle completion status
  void toggleCompletion() {
    isCompleted = !isCompleted;
  }

  // Create a copy of the task with updated fields
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

  // Helper method to get priority color
  Color getPriorityColor() {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }

  // Helper method to get priority icon
  IconData getPriorityIcon() {
    switch (priority) {
      case TaskPriority.low:
        return Icons.arrow_downward;
      case TaskPriority.medium:
        return Icons.remove;
      case TaskPriority.high:
        return Icons.arrow_upward;
    }
  }
}