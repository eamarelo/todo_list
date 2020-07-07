import 'package:todo_list/model/task_model.dart';

class TodoListState {}

class UninitializedTodoList extends TodoListState {}

class HasValueTodoState extends TodoListState {
  List<TaskModel> tasks;

  HasValueTodoState(this.tasks);
}
