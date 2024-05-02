import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:to_do_app/features/todo/domain/entities/to_do_modal.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodosLoading());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddOrUpdateTodo) {
      yield* _mapAddOrUpdateTodoToState(event.todo);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event.id);
    }
  }

  Stream<TodoState> _mapLoadTodosToState() async* {
    try {
      final todos = await repository.getTodos().first;
      yield TodosLoaded(todos);
    } catch (e) {
      yield TodoError("Failed to load todos");
    }
  }

  Stream<TodoState> _mapAddOrUpdateTodoToState(Todo todo) async* {
    try {
      await repository.addOrUpdateTodo(todo);
      yield* _mapLoadTodosToState();
    } catch (e) {
      yield TodoError("Failed to add/update todo");
    }
  }

  Stream<TodoState> _mapDeleteTodoToState(String id) async* {
    try {
      await repository.deleteTodo(id);
      yield* _mapLoadTodosToState();
    } catch (e) {
      yield TodoError("Failed to delete todo");
    }
  }
}
