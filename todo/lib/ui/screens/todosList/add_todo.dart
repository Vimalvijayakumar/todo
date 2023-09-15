import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/data/repositories/user_repository.dart';
import 'package:todo/ui/common_widgets/app_loader.dart';
import 'package:todo/ui/common_widgets/inputbox_widget.dart';
import 'package:todo/ui/common_widgets/toast_widget.dart';
import 'package:todo/ui/screens/todosList/todo_list.dart';
import 'package:todo/ui/screens/todosList/todo_list_cubit.dart';
import 'package:todo/utils/constats.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _headingTextController = TextEditingController();
  final _contentTextController = TextEditingController();

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
          "Create New Todo",
          style: TextStyle(
              fontSize: Constants.appbarTextSize, color: Colors.black),
        ),
      ),
      body: BlocConsumer<TodoListCubit, TodoListState>(
        listener: (context, state) {
          if (state is AddTodoFailure) {
            ShowAlert.showToast("Something went wrong please try agian");
          }
          if (state is AddTodoSuccess) {
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
          if (state is AddTodoLoader) {
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
                  Center(
                      child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.green)),
                      onPressed: () {
                        BlocProvider.of<TodoListCubit>(context).addTodo(
                            Timestamp.fromDate(DateTime.now()),
                            _headingTextController.text,
                            _contentTextController.text);
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
