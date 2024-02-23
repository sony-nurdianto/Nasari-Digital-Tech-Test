import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadi_flutter_test/blocs/todo_bloc/todo_bloc.dart';
import 'package:nadi_flutter_test/repository/models/todo_models.dart';
import 'package:nadi_flutter_test/views/pages/todo/todo_form_pages.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:nadi_flutter_test/views/components/dialog.dart';
import 'package:intl/intl.dart';

class TodoDetailPages extends StatelessWidget {
  final TodoModels todoData;
  //  final TodoDialogConfirmation dialogConfirmation = TodoDialogConfirmation();
  const TodoDetailPages({required this.todoData, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: TodoFormContent(
        todoData: todoData,
      ),
    );
  }
}

class TodoFormContent extends StatelessWidget {
  final TodoModels todoData;
  const TodoFormContent({required this.todoData, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text(
          'Todo Detail Pages',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoSuccess) {
            Navigator.pushNamed(context, '/todo');
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          alignment: Alignment.topCenter,
          child: Container(
            // padding: const EdgeInsets.all(16),
            // height: 60.h,
            constraints: BoxConstraints(maxHeight: 60.h),
            width: 80.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.blue[500],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        todoData.taskName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 170, 61, 189),
                              borderRadius: BorderRadius.circular(10)),
                          child: SingleChildScrollView(
                            child: Text(
                              todoData.status,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  // alignment: Alignment.centerRight,
                  child: Text(
                    'Due date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(todoData.dueDate))}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 67, 65, 65), fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 30.h),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    child: Text(
                      todoData.description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  // width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        // width: 1.w,
                        height: 5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 170, 61, 189)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoForm(
                                    title: 'Update', todoDataUpdate: todoData),
                              ),
                            );
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        // width: 1.w,
                        height: 5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 213, 13, 13)),
                          onPressed: () => TodoDialogConfirmation().dialogBuilder(
                              context,
                              'Are you sure you want to delete this data?',
                              'Deleting data is a irreversible action that will permanently remove the selected information. Please confirm your decision by clicking on the "Delete" button below. If you are unsure or wish to keep the data, you can click "Cancel" to abort the deletion process.\n\n Please be cautious as this action cannot be undone, and any associated records or information will be lost. Ensure that you have verified your decision before proceeding.',
                              () => context
                                  .read<TodoBloc>()
                                  .add(DeleteTodoList(id: todoData.id!))),
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
