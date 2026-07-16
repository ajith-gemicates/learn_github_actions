import 'package:learn_github_actions/sql_lite_lib/services/database_service.dart';

class TaskModel {
  final int id;
  final String taskName;
  final int taskDone;
  final String? createdAt;
  final String? updatedAt;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDone,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, Object?> toMap() {
    return {
      DatabaseService.taskTableTaskName: taskName,
      DatabaseService.taskTableTaskDone: taskDone,
      DatabaseService.taskTableCreatedAt: createdAt,
      DatabaseService.taskTableUpdatedAt: DateTime.now().toIso8601String(),
    };
  }
}
