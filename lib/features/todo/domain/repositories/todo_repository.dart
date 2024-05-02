
import 'package:to_do_app/features/todo/domain/entities/to_do_modal.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getTodos();
  Future<void> addOrUpdateTodo(Todo todo);
  Future<void> deleteTodo(String id);
}
