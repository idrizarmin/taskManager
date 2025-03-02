import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:task_manager/feature/domain/models/request_models/task_request_model.dart';
import 'package:task_manager/feature/domain/models/response_models/task_response_model.dart';
import 'package:task_manager/feature/domain/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;
  TaskBloc({required TaskRepository taskRepository})
    : _taskRepository = taskRepository,
      super(TaskInitialState()) {
    on<TaskLoadEvent>(_load);
    on<TaskAddEvent>(_add);
    on<TaskDeleteEvent>(_delete);
    on<TaskEditEvent>(_edit);
  }

  FutureOr<void> _load(TaskLoadEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoadingState());

      final tasks = await _taskRepository.load();

      emit(TaskLoadedState(tasks: tasks));
    } catch (e) {
      emit(TaskFailureState());
    }
  }

  FutureOr<void> _add(TaskAddEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoadingState());

      final upsertDto = TaskRequestModel(
        title: event.title,
        description: event.description,
      );

      await _taskRepository.add(upsertDto);

      emit(TaskFinishedState());
    } catch (e) {
      emit(TaskFailureState());
    }
  }

  FutureOr<void> _edit(TaskEditEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoadingState());

      await _taskRepository.update(event.taskId, event.isActive);

      emit(TaskUpdatedState());
    } catch (e) {
      emit(TaskFailureState());
    }
  }

  FutureOr<void> _delete(TaskDeleteEvent event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoadingState());

      await _taskRepository.delete(event.taskId);

      emit(TaskDeletedState());
    } catch (e) {
      emit(TaskFailureState());
    }
  }
}
