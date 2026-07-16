import 'package:equatable/equatable.dart';
import 'package:learn_github_actions/sql_lite_lib/model/task_model.dart';

class HomePageState extends Equatable {
  final String errorMsg;
  final bool isTaskUpload;

  final List<TaskModel> tasks;

  const HomePageState({
    this.errorMsg = '',
    this.isTaskUpload = false,
    this.tasks = const [],
  });

  HomePageState copyWith({
    String? errorMsg,
    bool? isTaskUpload,
    List<TaskModel>? tasks,
  }) {
    return HomePageState(
      errorMsg: errorMsg ?? this.errorMsg,
      isTaskUpload: isTaskUpload ?? this.isTaskUpload,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [errorMsg, isTaskUpload, tasks];
}
