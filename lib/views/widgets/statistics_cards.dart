import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/task_controller.dart';

class StatisticsCards extends StatelessWidget {
  const StatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context, controller, child) {
        return Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              _buildStatCard(
                context,
                'Total',
                controller.totalTaskCount.toString(),
                Icons.list_alt,
                Colors.blue,
                Colors.blue.shade50,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                context,
                'Completed',
                controller.completedTaskCount.toString(),
                Icons.check_circle,
                Colors.green,
                Colors.green.shade50,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                context,
                'Pending',
                controller.pendingTaskCount.toString(),
                Icons.pending_actions,
                Colors.orange,
                Colors.orange.shade50,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String label,
      String value,
      IconData icon,
      Color color,
      Color bgColor,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}