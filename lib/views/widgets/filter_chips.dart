import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/task_controller.dart';
import '../../models/task_model.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: controller.setSearchQuery,
                      decoration: InputDecoration(
                        hintText: 'Search tasks...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        controller.showCompleted ? Icons.filter_alt : Icons.filter_alt_off,
                        color: controller.showCompleted ? Colors.blue : Colors.grey,
                      ),
                      onPressed: controller.toggleShowCompleted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(
                      'All',
                      null,
                      controller.filterPriority,
                          () => controller.setFilterPriority(null),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'Low',
                      TaskPriority.low,
                      controller.filterPriority,
                          () => controller.setFilterPriority(TaskPriority.low),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'Medium',
                      TaskPriority.medium,
                      controller.filterPriority,
                          () => controller.setFilterPriority(TaskPriority.medium),
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      'High',
                      TaskPriority.high,
                      controller.filterPriority,
                          () => controller.setFilterPriority(TaskPriority.high),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
      String label,
      TaskPriority? priority,
      TaskPriority? selectedPriority,
      VoidCallback onSelected,
      ) {
    final isSelected = priority == selectedPriority;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.grey.shade100,
      selectedColor: _getPriorityColor(priority),
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Color _getPriorityColor(TaskPriority? priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}