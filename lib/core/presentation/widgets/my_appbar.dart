import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_api/core/presentation/theme/bloc/theme_bloc.dart';
import 'package:todos_api/feature/todo/presentation/bloc/todo_bloc.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<TodoBloc>().add(FetchTodosEvent()),
        ),
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDark = state is ThemeLoaded && state.isDark;
            return IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              tooltip: isDark ? 'Mode clair' : 'Mode sombre',
              onPressed: () =>
                  context.read<ThemeBloc>().add(const ThemeToggled()),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
