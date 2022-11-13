import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_conservation_app/main.dart';
import 'package:ocean_conservation_app/screens/todo_screen/core/keys.dart';

class IntroMeddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (preferences!.getBool(DISPLAYINTRO) != null)
      return RouteSettings(name: '/Todo');
  }
}
