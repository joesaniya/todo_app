import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:to_do_app/features/todo/data/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/domain/entities/to_do_modal.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodosLoading()) {
    // Registering event handlers with `on<>`
    on<LoadTodos>(_onLoadTodos);
    on<AddOrUpdateTodo>(_onAddOrUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) async {
    try {
      final todos = await repository.getTodos().first;
      emit(TodosLoaded(todos));
    } catch (e) {
      emit(TodoError("Failed to load todos"));
    }
  }

  Future<void> _onAddOrUpdateTodo(
    AddOrUpdateTodo event,
    Emitter<TodoState> emit,
  ) async {
    try {
      await repository.addOrUpdateTodo(event.todo);
      await _onLoadTodos(LoadTodos(), emit);
    } catch (e) {
      emit(TodoError("Failed to add/update todo"));
    }
  }

  Future<void> _onDeleteTodo(
    DeleteTodo event,
    Emitter<TodoState> emit,
  ) async {
    try {
      await repository.deleteTodo(event.id);
      await _onLoadTodos(LoadTodos(), emit);
    } catch (e) {
      emit(TodoError("Failed to delete todo"));
    }
  }
}
