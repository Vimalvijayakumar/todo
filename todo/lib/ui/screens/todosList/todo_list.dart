import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/data/repositories/user_repository.dart';
import 'package:todo/ui/common_widgets/app_loader.dart';
import 'package:todo/ui/common_widgets/toast_widget.dart';
import 'package:todo/ui/screens/todosList/add_todo.dart';
import 'package:todo/ui/screens/todosList/edit_todo.dart';
import 'package:todo/ui/screens/todosList/todo_list_cubit.dart';
import 'package:todo/utils/constats.dart';

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  @override
  void initState() {
    BlocProvider.of<TodoListCubit>(context).getTodosList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDos",
          style: TextStyle(
              fontSize: Constants.appbarTextSize, color: Colors.black),
        ),
      ),
      body: BlocConsumer<TodoListCubit, TodoListState>(
        listener: (context, state) {
          if (state is GetTodoListFailure) {
            ShowAlert.showToast("Something went wrong please try again");
          }
        },
        builder: (context, state) {
          if (state is GetTodoListLoader) {
            return const AppLoader();
          }
          if (state is GetTodoListSuccess) {
            var datalist = state.todosData;

            if (datalist.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.all(Constants.commonPadding),
                itemCount: datalist.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    dataItem: datalist[index],
                  );
                },
              );
            } else {
              return const Center(child: Text("No Data"));
            }
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => TodoListCubit(UserRepository()),
                        child: const AddTodo(),
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  final TodoModel dataItem;

  const TodoTile({
    super.key,
    required this.dataItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
          title: Text(
            dataItem.todoHeading.toString(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            dataItem.todoContent.toString(),
            style: TextStyle(color: Colors.grey[800], fontSize: 12.sp),
          ),
          trailing: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) =>
                                  TodoListCubit(UserRepository()),
                              child: EditTodo(todoItem: dataItem),
                            )));
              },
              child: const Icon(Icons.mode_edit_outline_outlined))),
    );
  }
}
