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

  const TaskAddEvent({this.id, required this.title, required this.description});

  @override
  List<Object?> get props => [id, title, description];
}

class TaskDeleteEvent extends TaskEvent {
  final String taskId;

  const TaskDeleteEvent({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
