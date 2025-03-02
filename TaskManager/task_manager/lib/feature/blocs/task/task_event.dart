part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class TaskLoadEvent extends TaskEvent {
  @override
  List<Object?> get props => [];
}

class TaskAddEvent extends TaskEvent {
  final String? id;
  final String title;
  final String description;
  final bool isActive = true;

  const TaskAddEvent({this.id, required this.title, required this.description});

  @override
  List<Object?> get props => [id, title, description];
}

class TaskEditEvent extends TaskEvent {
  final String taskId;
  final bool isActive;

  const TaskEditEvent({required this.taskId, required this.isActive});

  @override
  List<Object?> get props => [taskId, isActive];
}

class TaskDeleteEvent extends TaskEvent {
  final String taskId;

  const TaskDeleteEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
