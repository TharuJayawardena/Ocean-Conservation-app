import 'package:ocean_conservation_app/screens/todo_screen/data/provideData.dart/taskProvide.dart';
import 'package:ocean_conservation_app/models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
