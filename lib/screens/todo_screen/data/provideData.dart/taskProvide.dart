import 'dart:convert';

import 'package:get/get.dart';
import 'package:ocean_conservation_app/screens/todo_screen/core/keys.dart';
import 'package:ocean_conservation_app/screens/todo_screen/data/services/storage/sevices.dart';
import 'package:ocean_conservation_app/models/task.dart';

class TaskProvider{
  final _store=Get.find<StoreService>();

  List<Task> readTasks(){
    var tasks =<Task>[];
    dynamic temp= jsonDecode(_store.read(TASKKEY).toString());
    for(var e in temp){
      tasks.add(Task.fromjson(e));
    }
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    var temp=<dynamic>[];
    for(var e in tasks){
      temp.add(jsonEncode(e.tojson(e)));
    }

    _store.write(TASKKEY,temp);
  }
}