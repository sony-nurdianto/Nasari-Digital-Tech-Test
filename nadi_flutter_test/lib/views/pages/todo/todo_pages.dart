import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nadi_flutter_test/blocs/todo_bloc/todo_bloc.dart';
import 'package:nadi_flutter_test/repository/models/todo_models.dart';
import 'package:nadi_flutter_test/views/components/todo_list_card.dart';
import 'package:nadi_flutter_test/views/pages/todo/todo_detail_pages.dart';
import 'package:nadi_flutter_test/views/pages/todo/todo_form_pages.dart';

class TodoPages extends StatelessWidget {
  const TodoPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: const TodoContent(),
    );
  }
}

class TodoContent extends StatefulWidget {
  const TodoContent({super.key});

  @override
  State<TodoContent> createState() => _TodoContentState();
}

class _TodoContentState extends State<TodoContent> {
  late TodoBloc todoBloc;
  bool isLoading = false;
  List<TodoModels> dataTodo = [];

  @override
  void initState() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(GetTodoData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoLoading) {
          isLoading = true;
        }
        if (state is TodoLoaded) {
          dataTodo = state.todoData;
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[600],
            title: const Text(
              'Todo Pages',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: ListView.builder(
                    itemCount: dataTodo.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          // todoBloc.add(GoTodoDetail(todoDetailData: dataTodo[index]));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoDetailPages(
                                  todoData: dataTodo[index],
                                ),
                              ));
                        },
                        child: TodoListCard(
                          taskName: dataTodo[index].taskName,
                          description: dataTodo[index].description,
                          status: dataTodo[index].status,
                          dueDate: DateFormat('dd MMMM yyyy').format(DateTime.parse(dataTodo[index].dueDate)),
                          
                        ),
                      );
                    },
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: Colors.green[500],
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoForm(title: 'Add'),
                  ));
            },
            tooltip: 'Add Todo',
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
