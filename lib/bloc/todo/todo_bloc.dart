import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_event.dart';
import 'package:todo_list/bloc/todo/todo_state.dart';
import 'package:todo_list/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoBloc(TodoListState initialState) : super(initialState);

  @override
  Stream<TodoListState> mapEventToState(TodoListEvent event) async* {
    TodoRepository todoRepository = TodoRepository();

    if (event is AddTodoList) {
      todoRepository.todoElement.add(event.task);
      yield HasValueTodoState(todoRepository.todoElement);
    } else if (event is DelTodoList) {
      todoRepository.todoElement.removeAt(event.index);
      yield HasValueTodoState(todoRepository.todoElement);
    } else if (event is ResetEvent) {
      yield UninitializedTodoList();
    }
  }
}
