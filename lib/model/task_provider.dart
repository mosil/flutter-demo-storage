import 'dart:math';

import 'package:flutter/material.dart';
import 'package:storage/model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskModel> list = <TaskModel>[];

  void init() {
    _loadSample();
  }

  void _loadSample() {
    list.clear();
    final int r = Random().nextInt(20);
    if (r == 0) {
      return;
    }

    for (int i = 0; i < r; i++) {
      list.add(TaskModel.sample(i, 'Task $i'));
    }
  }
}
