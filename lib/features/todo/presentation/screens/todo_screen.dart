

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/todo/domain/entities/to_do_modal.dart';
import 'package:to_do_app/features/todo/presentation/blocs/todo_bloc.dart';
import 'package:to_do_app/features/todo/presentation/blocs/todo_event.dart';
import 'package:to_do_app/features/todo/presentation/blocs/todo_state.dart';


class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return CircularProgressIndicator();
          } else if (state is TodosLoaded) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      BlocProvider.of<TodoBloc>(context).add(
                        AddOrUpdateTodo(
                          Todo(
                            id: todo.id,
                            title: todo.title,
                            completed: value!,
                          ),
                        ),
                      );
                    },
                  ),
                  onLongPress: () {
                    BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo.id));
                  },
                );
              },
            );
          } else {
            return Text("Error loading todos");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new todo logic
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
