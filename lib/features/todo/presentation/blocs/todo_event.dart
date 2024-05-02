

import 'package:equatable/equatable.dart';
import 'package:to_do_app/features/todo/domain/entities/to_do_modal.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddOrUpdateTodo extends TodoEvent {
  final Todo todo;

  AddOrUpdateTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}
