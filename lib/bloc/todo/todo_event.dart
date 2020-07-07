import 'package:todo_list/model/task_model.dart';

class TodoListEvent {}

class AddTodoList extends TodoListEvent {
  final TaskModel task;
  AddTodoList(this.task);
}

class DelTodoList extends TodoListEvent {
  int index;
  DelTodoList(this.index);
}

class ResetEvent extends TodoListEvent {}
