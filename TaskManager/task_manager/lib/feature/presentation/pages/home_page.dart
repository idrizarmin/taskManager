import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:task_manager/common/constants/constants.dart';
import 'package:task_manager/feature/blocs/task/task_bloc.dart';
import 'package:task_manager/feature/domain/models/response_models/task_response_model.dart';
import 'package:task_manager/feature/domain/repositories/task_repository.dart';
import 'package:task_manager/feature/presentation/widgets/task_add_widget.dart';
import 'package:task_manager/feature/presentation/widgets/task_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TaskBloc _taskBloc;

  @override
  void initState() {
    _taskBloc = TaskBloc(taskRepository: context.read<TaskRepository>())
      ..add(TaskLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Constansts.applicationTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        foregroundColor: Colors.grey,
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskFinishedState) {
            _showMessage(Constansts.successAddEditTask);
            _taskBloc.add(TaskLoadEvent());
          } else if (state is TaskDeletedState) {
            _showMessage(Constansts.successDeleteTask);
          }
        },
        builder: (context, state) {
          if (state is TaskLoadedState) {
            if (state.tasks.isEmpty) {
              return Center(child: Text(Constansts.noTasks));
            }
            return RefreshIndicator(
              onRefresh: () async {
                _taskBloc.add(TaskLoadEvent());
              },
              child: ListView(
                padding: EdgeInsets.all(10),
                children:
                    state.tasks
                        .map(
                          (e) => TaskCardWidget(
                            task: e,
                            onPressedEdit: () => _onPressedEdit(e),
                            onPressedDelete: () => _onPressedDelete(e.id),
                          ),
                        )
                        .toList(),
              ),
            );
          } else if (state is TaskLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskFailureState) {
            return Center(child: Text(Constansts.errorOnLoadTasks));
          } else {
            return SizedBox.shrink();
          }
        },
        bloc: _taskBloc,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedAdd(context),
        backgroundColor: const Color.fromARGB(255, 64, 156, 100),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPressedAdd(BuildContext context) async {
    await TaskAddWidget.show(
      context,
      onConfirmed: (title, description) {
        _taskBloc.add(TaskAddEvent(title: title, description: description));
      },
    );
  }

  void _onPressedEdit(TaskResponseModel task) {
    setState(() => task.isActive = !task.isActive);
  }

  void _onPressedDelete(String id) {
    _taskBloc.add(TaskDeleteEvent(taskId: id));
  }

  void _showMessage(String message) async {
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: const Color.fromARGB(255, 5, 177, 13),
      textColor: Colors.white,
      fontSize: 18.0,
    );

    _taskBloc.add(TaskLoadEvent());
  }
}
