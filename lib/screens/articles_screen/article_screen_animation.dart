import 'package:flutter/material.dart';

import 'article_add_screen.dart';

class ArticleScreenAnimation {
  static late final AnimationController topTextController;
  static late final Animation<Offset> topTextAnimation;

  static late final AnimationController bottomTextController;
  static late final Animation<Offset> bottomTextAnimation;

  static final List<AnimationController> articleInitControllers = [];
  static final List<Animation<Offset>> articleInitAnimation = [];

  static final List<AnimationController> articleDescriptionControllers = [];
  static final List<Animation<Offset>> articleDescriptionAnimation = [];

  static var isPlaying = false;
  static var currentScreen = Screens.articleInit;

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
    required int articleInitItems,
    required int articleDescriptionItems,
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

    for (var i = 0; i < articleInitItems; i++) {
      articleInitControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      articleInitAnimation.add(
        _createAnimation(
          begin: Offset.zero,
          end: const Offset(-1, 0),
          parent: articleInitControllers[i],
        ),
      );
    }

    for (var i = 0; i < articleDescriptionItems; i++) {
      articleDescriptionControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      articleDescriptionAnimation.add(
        _createAnimation(
          begin: const Offset(1, 0),
          end: Offset.zero,
          parent: articleDescriptionControllers[i],
        ),
      );
    }
  }

  static void dispose() {
    for (final controller in [
      topTextController,
      bottomTextController,
      ...articleInitControllers,
      ...articleDescriptionControllers,
    ]) {
      controller.dispose();
    }
  }

  static Future<void> forward() async {
    isPlaying = true;

    topTextController.forward();
    await bottomTextController.forward();

    for (final controller in [
      ...articleInitControllers,
      ...articleDescriptionControllers,
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
      ...articleDescriptionControllers.reversed,
      ...articleInitControllers.reversed,
    ]) {
      controller.reverse();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    bottomTextController.reverse();
    await topTextController.reverse();

    isPlaying = false;
  }
}
