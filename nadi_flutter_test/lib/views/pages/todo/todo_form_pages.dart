import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadi_flutter_test/blocs/todo_bloc/todo_bloc.dart';
import 'package:nadi_flutter_test/repository/models/todo_models.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodoForm extends StatelessWidget {
  final String title;
  final TodoModels? todoDataUpdate;
  const TodoForm({required this.title, this.todoDataUpdate, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: TodoFormPage(
        title: title,
        todoDataUpdate: todoDataUpdate,
      ),
    );
  }
}

class TodoFormPage extends StatefulWidget {
  final String title;
  final TodoModels? todoDataUpdate;
  const TodoFormPage({required this.title, this.todoDataUpdate, super.key});

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  late TodoBloc todoBloc;
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  @override
  void initState() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    if (widget.title == 'Update') {
      _taskNameController.text = widget.todoDataUpdate!.taskName;
      _descriptionController.text = widget.todoDataUpdate!.description;
      _statusController.text = widget.todoDataUpdate!.status;
      _dueDateController.text = widget.todoDataUpdate!.dueDate;
    }
        if (widget.title != 'Update') {

      _statusController.text = 'On Going';

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoSuccess) {
          Navigator.pushNamed(context, '/todo');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[600],
          title: Text(
            '${widget.title} Todo Pages',
            style: const TextStyle(color: Colors.white),
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
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('Title'),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  controller: _taskNameController,
                  decoration: const InputDecoration(
                    // constraints: BoxConstraints(
                    //   maxHeight: 35
                    // ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    labelText: 'Input Title',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 170, 61, 189), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 0.0),
                    ),
                    labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Text('Due Date'),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  controller: _dueDateController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 1),
                    border: OutlineInputBorder(),
                    labelText: 'Input DueDate',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 170, 61, 189), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 0.0),
                    ),
                    labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime argument = DateTime(2021, 7, 25);
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate: DateTime.fromMillisecondsSinceEpoch(
                          argument.millisecondsSinceEpoch),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2022),
                    );
                    setState(() {
                      _dueDateController.text = selectedDate.toString();
                    });
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Text('Description'),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  controller: _descriptionController,

                  // focusNode: _descriptionFocusNode,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 1),
                    border: OutlineInputBorder(),
                    labelText: 'Input Description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 170, 61, 189), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 0.0),
                    ),
                    labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  maxLines: null,
                  // style: const TextStyle(fontSize: 12.0),
                  // decoration: const InputDecoration(labelText: 'Password'),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Text('Status'),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: const Color.fromARGB(55, 170, 61, 189),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          items: const [
                            DropdownMenuItem(
                              value: 'On Going',
                              child: Text('On Going'),
                            ),
                            DropdownMenuItem(
                              value: 'Done',
                              child: Text('Done'),
                            )
                          ],
                          alignment: Alignment.bottomCenter,
                          value: _statusController.value.text  ,
                          // value: 'On Going',
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _statusController.text = value;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.green[500],
          onPressed: () {
            // Navigator.pushNamed(context, '/todo');
            if (widget.title == 'Update') {
              todoBloc.add(UpdateTodoList(todoDetailData: TodoModels(
                    id: widget.todoDataUpdate?.id,
                    taskName: _taskNameController.value.text,
                    description: _descriptionController.value.text,
                    dueDate: _dueDateController.value.text,
                    status: widget.title == 'Update'
                        ? _statusController.value.text
                        : "On Going",
                  ),),);
            }
            if (widget.title == 'Add') {
              todoBloc.add(
                CreateTodoList(
                  todoDetailData: TodoModels(
                    id: widget.todoDataUpdate?.id,
                    taskName: _taskNameController.value.text,
                    description: _descriptionController.value.text,
                    dueDate: _dueDateController.value.text,
                    status:  "On Going",
                  ),
                ),
              );
            }
          },
          tooltip: 'Add Todo',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
