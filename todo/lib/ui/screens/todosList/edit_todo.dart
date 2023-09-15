import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/models/todo_model.dart';
import 'package:todo/data/repositories/user_repository.dart';
import 'package:todo/ui/common_widgets/app_loader.dart';
import 'package:todo/ui/common_widgets/inputbox_widget.dart';
import 'package:todo/ui/common_widgets/toast_widget.dart';
import 'package:todo/ui/screens/todosList/todo_list.dart';
import 'package:todo/ui/screens/todosList/todo_list_cubit.dart';
import 'package:todo/utils/constats.dart';

class EditTodo extends StatefulWidget {
  final TodoModel todoItem;
  const EditTodo({super.key, required this.todoItem});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _headingTextController = TextEditingController();
  final _contentTextController = TextEditingController();

  @override
  void initState() {
    _headingTextController.text = widget.todoItem.todoHeading.toString();
    _contentTextController.text = widget.todoItem.todoContent.toString();
    super.initState();
  }

  @override
  void dispose() {
    _headingTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Todo",
          style: TextStyle(
              fontSize: Constants.appbarTextSize, color: Colors.black),
        ),
      ),
      body: BlocConsumer<TodoListCubit, TodoListState>(
        listener: (context, state) {
          if (state is UpdateTodoFailure) {
            ShowAlert.showToast("Upadtion Failure Please try again");
          }
          if (state is DeleteFailure) {
            ShowAlert.showToast("Deletion Failure Please try again");
          }
          if (state is UpdateTodoSuccess) {
            ShowAlert.showToast("Updated Successfully");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => TodoListCubit(UserRepository()),
                          child: const TodosList(),
                        )),
                (route) => false);
          }
          if (state is DeleteSuccess) {
            ShowAlert.showToast("Deleted Successfully");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => TodoListCubit(UserRepository()),
                          child: const TodosList(),
                        )),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is UpdateTodoLoading) {
            return const AppLoader();
          }
          if (state is DeleteLoading) {
            return const AppLoader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Heading"),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextBox(
                    controller: _headingTextController,
                    hintText: 'Enter Todo heading',
                    maxlines: 1,
                    boxheight: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Content"),
                  const SizedBox(
                    height: 10,
                  ),
                  InputTextBox(
                    controller: _contentTextController,
                    hintText: 'Todo Content',
                    maxlines: 5,
                    boxheight: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () {
                            BlocProvider.of<TodoListCubit>(context)
                                .deletetodo(widget.todoItem.id.toString());
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          onPressed: () {
                            BlocProvider.of<TodoListCubit>(context).updateTodo(
                                widget.todoItem.id.toString(),
                                TodoModel(
                                    date: Timestamp.fromDate(DateTime.now()),
                                    todoContent: _contentTextController.text,
                                    todoHeading: _headingTextController.text));
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
