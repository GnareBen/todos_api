import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todos_api/core/network/dio_client.dart';
import 'package:todos_api/feature/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todos_api/feature/todo/data/repositories/todo_repository_impl.dart';
import 'package:todos_api/feature/todo/domain/repositories/todo_repository.dart';
import 'package:todos_api/feature/todo/domain/usecase/get_todos.dart';
import 'package:todos_api/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:todos_api/feature/todo/presentation/pages/todo_page.dart';

final sl = GetIt.instance; // Service Locator

void main() {
  _initDependencies();
  runApp(const MyApp());
}

/// Service Locator (get_it) — alternatif à injectable pour garder
/// la simplicité. Pour un projet de grande taille, utilise
/// @injectable + build_runner.
void _initDependencies() {
  // Core
  sl.registerLazySingleton(() => DioClient.instance);

  // Data sources
  sl.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTodos(sl()));

  // BLoCs — registerFactory pour créer une nouvelle instance à chaque fois
  sl.registerFactory(() => TodoBloc(getTodos: sl()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Clean App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: BlocProvider(
        create: (_) => sl<TodoBloc>()..add(FetchTodosEvent()),
        child: const TodoPage(),
      ),
    );
  }
}
