import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskController extends ChangeNotifier {
  List<Task> _tasks = [];
  String _searchQuery = '';
  TaskPriority? _filterPriority;
  bool _showCompleted = true;

  // Getters
  List<Task> get tasks => _getFilteredTasks();
  List<Task> get allTasks => _tasks;
  String get searchQuery => _searchQuery;
  TaskPriority? get filterPriority => _filterPriority;
  bool get showCompleted => _showCompleted;

  // Get filtered tasks based on search, priority, and completion
  List<Task> _getFilteredTasks() {
    var filtered = _tasks.where((task) {
      // Search filter
      final matchesSearch = _searchQuery.isEmpty ||
          task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (task.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

      // Priority filter
      final matchesPriority = _filterPriority == null || task.priority == _filterPriority;

      // Completion filter
      final matchesCompletion = _showCompleted || !task.isCompleted;

      return matchesSearch && matchesPriority && matchesCompletion;
    }).toList();

    // Sort by priority (high to low) and then by creation date
    filtered.sort((a, b) {
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      final priorityCompare = b.priority.index.compareTo(a.priority.index);
      if (priorityCompare != 0) return priorityCompare;
      return b.createdAt.compareTo(a.createdAt);
    });

    return filtered;
  }

  // Task statistics
  int get totalTaskCount => _tasks.length;
  int get completedTaskCount => _tasks.where((task) => task.isCompleted).length;
  int get pendingTaskCount => totalTaskCount - completedTaskCount;
  int get highPriorityCount => _tasks.where((task) => task.priority == TaskPriority.high && !task.isCompleted).length;

  // CRUD Operations
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void addTaskWithDetails({
    required String title,
    String? description,
    DateTime? dueDate,
    TaskPriority priority = TaskPriority.medium,
  }) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex].toggleCompletion();
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  // Filter methods
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterPriority(TaskPriority? priority) {
    _filterPriority = priority;
    notifyListeners();
  }

  void toggleShowCompleted() {
    _showCompleted = !_showCompleted;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _filterPriority = null;
    _showCompleted = true;
    notifyListeners();
  }

  // Bulk operations
  void clearCompletedTasks() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }

  void deleteAllTasks() {
    _tasks.clear();
    notifyListeners();
  }
}