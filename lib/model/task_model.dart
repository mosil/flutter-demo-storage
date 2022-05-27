class TaskModel {
  int id;
  String title;

  TaskModel({required this.id, required this.title});

  factory TaskModel.sample(int id, String title) {
    return TaskModel(id: id, title: title);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title};
  }
}
