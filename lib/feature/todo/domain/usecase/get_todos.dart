import 'package:dartz/dartz.dart';
import 'package:todos_api/core/error/failures.dart';
import 'package:todos_api/core/usecase/usecase.dart';
import 'package:todos_api/feature/todo/domain/entities/todo.dart';
import 'package:todos_api/feature/todo/domain/repositories/todo_repository.dart';

class GetTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  const GetTodos(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) {
    return repository.getTodos();
  }
}