class TaskModel {
  final int id;
  final String title;
  final String description;

  @override
  String toString() {
    return 'title: $title, description: $description';
  }

  TaskModel(this.id, this.title, this.description);
}
