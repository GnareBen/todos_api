import 'package:dartz/dartz.dart';
import 'package:todos_api/core/error/failures.dart';
import 'package:todos_api/feature/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
}