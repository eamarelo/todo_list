import 'package:todo_list/model/task_model.dart';

class TodoRepository {
  List<TaskModel> todoElement = [];

  static final TodoRepository _counterRepository = TodoRepository._internal();

  factory TodoRepository() {
    return _counterRepository;
  }

  TodoRepository._internal();
}
