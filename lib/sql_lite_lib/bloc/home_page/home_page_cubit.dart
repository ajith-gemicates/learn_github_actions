import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learn_github_actions/sql_lite_lib/bloc/home_page/home_page_state.dart';
import 'package:learn_github_actions/sql_lite_lib/services/database_service.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState()) {
    init();
  }

  DatabaseService databaseService = DatabaseService();
  TextEditingController taskNameController = TextEditingController();

  void init() {
    databaseService.getDataBase();
    getTasks();
  }

  Future<void> getTasks() async {
    try {
      final tasks = await databaseService.getTasks();
      emit(state.copyWith(tasks: tasks.reversed.toList()));
    } catch (e) {
      debugPrint('the getTasks exp is ----- $e');
    }
  }

  Future<void> addTask() async {
    try {
      final response = await databaseService.addTask(taskNameController.text);
      emit(state.copyWith(isTaskUpload: response != 0));
      emit(state.copyWith(isTaskUpload: false));
      taskNameController.clear();
      await getTasks();
    } catch (e) {
      debugPrint('the addTask exp is ----- $e');
    }
  }
}
