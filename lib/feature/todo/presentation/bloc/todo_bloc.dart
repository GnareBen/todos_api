import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_api/core/usecase/usecase.dart';
import 'package:todos_api/feature/todo/domain/entities/todo.dart';
import 'package:todos_api/feature/todo/domain/usecase/get_todos.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  TodoBloc({required this.getTodos}) : super(TodoInitial()) {
    on<FetchTodosEvent>(_onFetchTodos);
  }

  Future<void> _onFetchTodos(
    FetchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final result = await getTodos(NoParams());
    result.fold(
      (failure) => emit(TodoError(message: failure.message)),
      (todos) => emit(TodoLoaded(todos: todos)),
    );
  }
}
