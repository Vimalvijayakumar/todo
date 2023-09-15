part of 'todo_list_cubit.dart';

@immutable
sealed class TodoListState {}

final class TodoListInitial extends TodoListState {}

class AddTodoLoader extends TodoListState {}

class GetTodoListLoader extends TodoListState {}

class GetTodoListSuccess extends TodoListState {
  final List<TodoModel> todosData;

  GetTodoListSuccess(this.todosData);
}

class GetTodoListFailure extends TodoListState {
  final String error;

  GetTodoListFailure(this.error);
}

class AddTodoSuccess extends TodoListState {
  final String id;

  AddTodoSuccess(this.id);
}

class AddTodoFailure extends TodoListState {
  final String error;

  AddTodoFailure(this.error);
}

class UpdateTodoLoading extends TodoListState {}

class UpdateTodoSuccess extends TodoListState {}

class UpdateTodoFailure extends TodoListState {
  final String error;

  UpdateTodoFailure(this.error);
}

class DeleteLoading extends TodoListState {}

class DeleteSuccess extends TodoListState {}

class DeleteFailure extends TodoListState {
  final String error;

  DeleteFailure(this.error);
}
