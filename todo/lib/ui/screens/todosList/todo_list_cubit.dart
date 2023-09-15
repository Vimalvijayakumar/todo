import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/data/repositories/user_repository.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  final UserRepository _repository;

  TodoListCubit(this._repository) : super(TodoListInitial());

  void getTodosList() async {
    emit(GetTodoListLoader());
    try {
      List<TodoModel> todoData = await _repository.getTodos();
      emit(GetTodoListSuccess(todoData));
    } catch (e) {
      emit(GetTodoListFailure(e.toString()));
    }
  }

  void addTodo(Timestamp date, String heading, String content) async {
    emit(AddTodoLoader());
    try {
      DocumentReference result = await _repository.addTodo(
          TodoModel(date: date, todoContent: content, todoHeading: heading));
      print(result.id);
      emit(AddTodoSuccess(result.id));
    } catch (e) {
      emit(AddTodoFailure(e.toString()));
    }
  }

  void updateTodo(String id, TodoModel todoData) async {
    emit(UpdateTodoLoading());
    try {
      await _repository.updateTodo(id, todoData);
      emit(UpdateTodoSuccess());
    } catch (e) {
      emit(UpdateTodoFailure(e.toString()));
    }
  }

  void deletetodo(String id) async {
    emit(DeleteLoading());
    try {
      await _repository.deleteTodo(id);
      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteFailure(e.toString()));
    }
  }
}
