import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_bloc.dart';
import 'package:todo_list/bloc/todo/todo_event.dart';
import 'package:todo_list/bloc/todo/todo_state.dart';
import 'package:todo_list/model/task_model.dart';

class HomePage extends StatelessWidget {
  final _id = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO LIST'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: BlocBuilder<TodoBloc, TodoListState>(
              builder: (context, state) {
                if (state is UninitializedTodoList) {
                  return Text('Uninitialized');
                } else if (state is HasValueTodoState) {
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              title: Text(
                                state.tasks[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              subtitle: Text(
                                state.tasks[index].description,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 30.0,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  BlocProvider.of<TodoBloc>(context)
                                      .add(DelTodoList(index));
                                },
                              )));
                    },
                  );
                }
                return Text('error');
              },
            ),
          ),
          Container(
            height: 32,
          ),
          FlatButton(
            color: Colors.blue,
            child: Text(
              'Add Task',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              titleController.text = "";
              desController.text = "";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Form(
                            key: _id,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter a title'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: desController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter a description'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text("Create a Task"),
                                    onPressed: () {
                                      if (_id.currentState.validate()) {
                                        BlocProvider.of<TodoBloc>(context).add(
                                            AddTodoList(TaskModel(
                                                0,
                                                titleController.text,
                                                desController.text)));
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
