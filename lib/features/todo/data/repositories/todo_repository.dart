import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/features/todo/domain/entities/to_do_modal.dart';
import 'package:to_do_app/features/todo/domain/repositories/todo_repository.dart';

class FirebaseTodoRepository implements TodoRepository {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  @override
  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Todo(
              id: doc.id,
              title: doc['title'],
              completed: doc['completed'],
            ))
        .toList());
  }

  @override
  Future<void> addOrUpdateTodo(Todo todo) {
    if (todo.id.isEmpty) {
      return _todosCollection.add({
        'title': todo.title,
        'completed': todo.completed,
      });
    } else {
      return _todosCollection.doc(todo.id).set({
        'title': todo.title,
        'completed': todo.completed,
      });
    }
  }

  @override
  Future<void> deleteTodo(String id) {
    return _todosCollection.doc(id).delete();
  }
}
