import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ocean_conservation_app/screens/home_screen/home_page.dart';
import 'package:ocean_conservation_app/screens/todo_screen/controller/homecontroller.dart';
import 'package:ocean_conservation_app/screens/todo_screen/core/extensions.dart';
import 'package:ocean_conservation_app/models/task.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/home/home.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/home/widgets/addDialog.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/report.dart';
import 'package:ocean_conservation_app/utils/constants.dart';

class Demopagestate extends StatelessWidget {
  Demopagestate({Key? key}) : super(key: key);
  var control = Get.find<Homecontroller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          centerTitle: true,
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.to(() => const HomePage());
            },
          ),
          title: const Text(
            'Todo',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),
          )),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor:
                  control.deleting.value ? Colors.red : kSecondaryColor,
              onPressed: () {
                if (control.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo("Please create your task type");
                }
              },
              child: Icon(control.deleting.value ? Icons.delete : Icons.add,
                  color: Colors.white, size: 30),
            ),
          );
        },
        onAccept: (Task task) {
          control.deletetask(task);
          EasyLoading.showSuccess("Delete Sucess");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: kSecondaryColor,
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0.wp),
                child: IconButton(
                    onPressed: () {
                      control.changemypage(0);
                    },
                    icon: const Icon(
                      Icons.list_alt_rounded,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0.wp),
                child: IconButton(
                    onPressed: () {
                      control.changemypage(1);
                    },
                    icon: const Icon(Icons.data_saver_off_rounded,
                        color: Colors.white, size: 30)),
              ),
            ],
          )),
      body: PageView(
        controller: control.mypage,
        children: [
          Home(),
          Report(),
        ],
      ),
    );
  }
}
