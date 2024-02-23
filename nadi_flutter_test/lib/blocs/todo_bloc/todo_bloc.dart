import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nadi_flutter_test/repository/data/todo_data.dart';
import 'package:nadi_flutter_test/repository/models/todo_models.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoData todoData = TodoData();

  TodoBloc() : super(TodoInitial()) {
    on<GetTodoData>((event, emit) async {
      emit(TodoLoading());
      try {
        final List<TodoModels> data = await todoData.getDataTodo();
        emit(TodoLoaded(todoData: data));
      } catch (e) {
        emit(TodoFailure(error: 'gagal mendapatkan data'));
      }
    });
    on<CreateTodoList>(
      (event, emit) async {
        emit(TodoLoading());
        try {
          await todoData.inputDataTodo(event.todoDetailData);
          emit(TodoSuccess());
        } catch (e) {
          emit(TodoFailure(error: 'gagal mendapatkan data'));
        }
      },
    );

    on<UpdateTodoList>(
      (event, emit) async {
        emit(TodoLoading());
        try {
          await todoData.updateDataTodo(event.todoDetailData);
          emit(TodoSuccess());
        } catch (e) {
          emit(TodoFailure(error: 'gagal mendapatkan data'));
        }
      },
    );

        on<DeleteTodoList>(
      (event, emit) async {
        emit(TodoLoading());
        try {
          await todoData.deleteDataTodo(event.id);
          emit(TodoSuccess());
        } catch (e) {
          emit(TodoFailure(error: 'gagal mendapatkan data'));
        }
      },
    );
  }
}
