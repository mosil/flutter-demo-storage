import 'dart:math';

import 'package:flutter/material.dart';
import 'package:storage/constant/app_key.dart';
import 'package:storage/database_helper.dart';
import 'package:storage/model/task_model.dart';

class TaskProvider extends ChangeNotifier {
  TextEditingController taskController = TextEditingController();
  List<TaskModel> list = <TaskModel>[];

  Future<void> init() async {
    DatabaseHelper.instance.fetchAll().then((value) {
      for (var element in value) {
        list.add(
          TaskModel(
            id: element[AppKey.kId],
            title: element[AppKey.kTitle],
          ),
        );
      }
      notifyListeners();
    }).catchError((error) {
      debugPrint(error);
    });
  }

  Future<void> add() async {
    String title = taskController.text.trim();
    if (title.isEmpty) {
      return;
    }
    int id = await DatabaseHelper.instance.insert(TaskModel(title: title));
    list.insert(0, TaskModel(id: id, title: title));
    taskController.text = '';
    notifyListeners();
  }

  Future<void> delete(TaskModel model) async {
    await DatabaseHelper.instance.delete(model.id!);
    list.remove(model);
    notifyListeners();
  }

  Future<void> clear() async {
    list.clear();
    await DatabaseHelper.instance.clear();
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
