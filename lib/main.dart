import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_api/core/network/dio_client.dart';
import 'package:todos_api/core/presentation/theme/bloc/theme_bloc.dart';
import 'package:todos_api/core/presentation/theme/my_theme.dart';
import 'package:todos_api/feature/todo/data/datasources/todo_remote_datasource.dart';
import 'package:todos_api/feature/todo/data/repositories/todo_repository_impl.dart';
import 'package:todos_api/feature/todo/domain/repositories/todo_repository.dart';
import 'package:todos_api/feature/todo/domain/usecase/get_todos.dart';
import 'package:todos_api/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:todos_api/feature/todo/presentation/pages/todo_page.dart';

final sl = GetIt.instance; // Service Locator

void main() async {
  _initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeBloc(prefs: prefs)..add(const ThemeStarted()),
        ),
        BlocProvider(
          create: (_) => TodoBloc(getTodos: sl())..add(FetchTodosEvent()),
        ),
      ],
      child: const AppRoot(),
    ),
  );
}

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
  sl.registerFactory(() => ThemeBloc(prefs: sl()));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final themeMode = state is ThemeLoaded
            ? state.themeMode
            : ThemeMode.system; // fallback pendant ThemeInitial

        return MaterialApp(
          title: 'Todo Clean App',
          debugShowCheckedModeBanner: false,
          theme: MyTheme.light,
          darkTheme: MyTheme.dark,
          themeMode: themeMode,
          home: const TodoPage(),
        );
      },
    );
  }
}
