part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}


class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoSuccess extends TodoState {}


class TodoLoaded extends TodoState {

  final List<TodoModels> todoData;

  TodoLoaded({required this.todoData});
}



class TodoFailure extends TodoState {
  final String error;

  TodoFailure({required this.error});
}