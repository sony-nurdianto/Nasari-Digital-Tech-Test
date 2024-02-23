part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}


class GetTodoData extends TodoEvent {}

class CreateTodoList extends TodoEvent {
  final TodoModels todoDetailData;
  CreateTodoList({required this.todoDetailData});
}

class UpdateTodoList extends TodoEvent {
  final TodoModels todoDetailData;
  UpdateTodoList({required this.todoDetailData});
}

class DeleteTodoList extends TodoEvent {
  final String id;
  DeleteTodoList({required this.id});
}