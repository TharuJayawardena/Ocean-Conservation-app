import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ocean_conservation_app/main.dart';
import 'package:ocean_conservation_app/screens/todo_screen/core/keys.dart';
import 'package:ocean_conservation_app/models/introcontent.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/home/widgets/demopagestate.dart';

class IntroController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pagecontroller = PageController();

  actionbutton() {
    if (currentIndex.value == contents.length - 1) {
      preferences!.setBool(DISPLAYINTRO, true);
      Get.off(() => Demopagestate());
    }
    pagecontroller.nextPage(duration: 800.milliseconds, curve: Curves.ease);
  }

  List<IntroContent> contents = [
    IntroContent(
        imageName: "assets/icons/taking-notes-amico.png",
        title: "Create Your Task",
        description:
            "Create your task to make sure every task you have can completed on time"),
    IntroContent(
        imageName: "assets/icons/to-do-list-cuate.png",
        title: "Manage your Daily Task",
        description:
            "By using this application you will be able to manage your daily tasks"),
    IntroContent(
        imageName: "assets/icons/writing-a-letter-rafiki.png",
        title: "Checklist Finished Task",
        description:
            "If you completed your task, so you can view the result you work for each day")
  ];
}

class sharedprefsintro {}
