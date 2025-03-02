part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

final class TaskInitialState extends TaskState {
  const TaskInitialState();

  @override
  List<Object?> get props => [];
}

final class TaskLoadingState extends TaskState {
  const TaskLoadingState();

  @override
  List<Object?> get props => [];
}

final class TaskLoadedState extends TaskState {
  final List<TaskResponseModel> tasks;

  const TaskLoadedState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

final class TaskFailureState extends TaskState {
  final Exception? exception;

  const TaskFailureState({this.exception});

  @override
  List<Object?> get props => [exception];
}

final class TaskFinishedState extends TaskState {
  const TaskFinishedState();

  @override
  List<Object?> get props => [];
}

final class TaskDeletedState extends TaskState {
  const TaskDeletedState();

  @override
  List<Object?> get props => [];
}
