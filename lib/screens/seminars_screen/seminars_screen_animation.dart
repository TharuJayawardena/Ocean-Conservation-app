import 'package:flutter/material.dart';

import 'seminars_add_screen.dart';

class SeminarScreenAnimation {
  static late final AnimationController topTextController;
  static late final Animation<Offset> topTextAnimation;

  static late final AnimationController bottomTextController;
  static late final Animation<Offset> bottomTextAnimation;

  static final List<AnimationController> seminarInitControllers = [];
  static final List<Animation<Offset>> seminarInitAnimation = [];

  static final List<AnimationController> seminarDescriptionControllers = [];
  static final List<Animation<Offset>> seminarDescriptionAnimation = [];

  static var isPlaying = false;
  static var currentScreen = Screens.seminarInit;






  static Animation<Offset> _createAnimation({
    required Offset begin,
    required Offset end,
    required AnimationController parent,
  }) {
    return Tween(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: parent,
        curve: Curves.easeInOut,
      ),
    );
  }

  static void initialize({
    required TickerProvider vsync,
    required int seminarInitItems,
    required int seminarDescriptionItems,
  }) {
    topTextController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );

    topTextAnimation = _createAnimation(
      begin: Offset.zero,
      end: const Offset(-1.2, 0),
      parent: topTextController,
    );

    bottomTextController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );

    bottomTextAnimation = _createAnimation(
      begin: Offset.zero,
      end: const Offset(0, 1.7),
      parent: bottomTextController,
    );

    for (var i = 0; i < seminarInitItems; i++) {
      seminarInitControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      seminarInitAnimation.add(
        _createAnimation(
          begin: Offset.zero,
          end: const Offset(-1, 0),
          parent: seminarInitControllers[i],
        ),
      );
    }

    for (var i = 0; i < seminarDescriptionItems; i++) {
      seminarDescriptionControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      seminarDescriptionAnimation.add(
        _createAnimation(
          begin: const Offset(1, 0),
          end: Offset.zero,
          parent: seminarDescriptionControllers[i],
        ),
      );
    }
  }

  static void dispose() {
    for (final controller in [
      topTextController,
      bottomTextController,
      ...seminarInitControllers,
      ...seminarDescriptionControllers,
    ]) {
      controller.dispose();
    }
  }

  static Future<void> forward() async {
    isPlaying = true;

    topTextController.forward();
    await bottomTextController.forward();

    for (final controller in [
      ...seminarInitControllers,
      ...seminarDescriptionControllers,
    ]) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    bottomTextController.reverse();
    await topTextController.reverse();

    isPlaying = false;
  }

  static Future<void> reverse() async {
    isPlaying = true;

    topTextController.forward();
    await bottomTextController.forward();

    for (final controller in [
      ...seminarDescriptionControllers.reversed,
      ...seminarInitControllers.reversed,
    ]) {
      controller.reverse();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    bottomTextController.reverse();
    await topTextController.reverse();

    isPlaying = false;
  }
}
