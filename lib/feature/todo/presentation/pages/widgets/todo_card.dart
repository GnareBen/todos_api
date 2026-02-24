import 'package:flutter/material.dart';
import 'package:todos_api/feature/todo/domain/entities/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: todo.completed
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant,
          child: Icon(
            todo.completed ? Icons.check : Icons.pending_outlined,
            color: todo.completed
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.label_outline, size: 14),
            const SizedBox(width: 4),

            const SizedBox(width: 12),
            const Icon(Icons.person_outline, size: 14),
            const SizedBox(width: 4),
          ],
        ),
        trailing: Chip(
          label: Text(
            todo.completed ? 'Fait' : 'En cours',
            style: const TextStyle(fontSize: 11),
          ),
          backgroundColor: todo.completed
              ? Colors.green.shade100
              : Colors.orange.shade100,
        ),
      ),
    );
  }
}