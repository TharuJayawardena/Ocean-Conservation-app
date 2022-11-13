import 'package:get/get.dart';
import 'package:ocean_conservation_app/screens/todo_screen/controller/homecontroller.dart';
import 'package:ocean_conservation_app/screens/todo_screen/data/provideData.dart/taskProvide.dart';
import 'package:ocean_conservation_app/screens/todo_screen/data/services/storage/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Homecontroller(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
