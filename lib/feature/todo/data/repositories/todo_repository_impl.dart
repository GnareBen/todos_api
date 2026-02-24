import 'package:dartz/dartz.dart';
import 'package:todos_api/core/error/failures.dart';
import 'package:todos_api/feature/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todos_api/feature/todo/domain/entities/todo.dart';
import 'package:todos_api/feature/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  const TodoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await remoteDataSource.getTodos();
      return Right(todos);
    } on ServerFailure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}