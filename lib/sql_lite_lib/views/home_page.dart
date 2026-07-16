import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_github_actions/sql_lite_lib/bloc/home_page/home_page_cubit.dart';
import 'package:learn_github_actions/sql_lite_lib/bloc/home_page/home_page_state.dart';
import 'package:learn_github_actions/sql_lite_lib/model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomePageCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('SqlFlite Demo Project')),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: cubit.taskNameController),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () async {
                        await cubit.addTask();
                        await cubit.getTasks();
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    final cubit = context.read<HomePageCubit>();
    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state.isTaskUpload) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.tasks.length,
                itemBuilder: (context, index) {
                  TaskModel taskData = state.tasks[index];
                  return ListTile(title: Text(taskData.taskName));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
