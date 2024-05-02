import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/todo/data/repositories/todo_repository.dart';
import 'package:to_do_app/features/todo/presentation/blocs/todo_bloc.dart';
import 'package:to_do_app/features/todo/presentation/blocs/todo_event.dart';
import 'package:to_do_app/features/todo/presentation/screens/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            TodoBloc(FirebaseTodoRepository())..add(LoadTodos()),
        child: TodoPage(),
      ),
    );
  }
}
