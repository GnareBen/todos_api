import 'package:dio/dio.dart';
import 'package:todos_api/core/error/failures.dart';
import 'package:todos_api/feature/todo/data/models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio dio;

  const TodoRemoteDataSourceImpl(this.dio);

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      final response = await dio.get('/todos');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => TodoModel.fromJson(json)).toList();
      }

      throw ServerFailure('Unexpected status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerFailure(_mapDioError(e));
    }
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet.';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode}';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
