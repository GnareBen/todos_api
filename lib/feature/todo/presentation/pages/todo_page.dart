// lib/features/todo/presentation/pages/todo_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_api/core/presentation/widgets/my_appbar.dart';
import 'package:todos_api/feature/todo/domain/entities/todo.dart';
import 'package:todos_api/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:todos_api/feature/todo/presentation/widgets/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: 'Mes Todos'), 
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return _buildInitial(context);
          } else if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            return _buildList(state.todos);
          } else if (state is TodoError) {
            return _buildError(context, state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.download),
        label: const Text('Charger les Todos'),
        onPressed: () => context.read<TodoBloc>().add(FetchTodosEvent()),
      ),
    );
  }

  Widget _buildList(List<Todo> todos) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: todos.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoCard(todo: todo);
      },
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<TodoBloc>().add(FetchTodosEvent()),
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
}
