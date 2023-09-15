import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/data/models/todo_model.dart';

class UserRepository {
  final CollectionReference todoList =
      FirebaseFirestore.instance.collection("todo_list");

  Future<List<TodoModel>> getTodos() async {
    List<TodoModel> listData = [];
    var data = await todoList.orderBy("date", descending: true).get();
    if (data.docs.isNotEmpty) {
      listData =
          data.docs.map((e) => TodoModel.fromJson(e.data(), e.id)).toList();
    }
    return listData;
  }

  Future<DocumentReference> addTodo(TodoModel todo) {
    return todoList.add(todo.tojson());
  }

  Future<void> updateTodo(String id, TodoModel data) async {
    await todoList.doc(id).update(data.tojson());
  }

  Future<void> deleteTodo(String id) async {
    await todoList.doc(id).delete();
  }
}
