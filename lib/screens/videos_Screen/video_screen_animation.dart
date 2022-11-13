import 'package:flutter/material.dart';

import 'video_add_screen.dart';

class VideoScreenAnimation {
  static late final AnimationController topTextController;
  static late final Animation<Offset> topTextAnimation;

  static late final AnimationController bottomTextController;
  static late final Animation<Offset> bottomTextAnimation;

  static final List<AnimationController> videoInitControllers = [];
  static final List<Animation<Offset>> videoInitAnimation = [];

  static final List<AnimationController> videoDescriptionControllers = [];
  static final List<Animation<Offset>> videoDescriptionAnimation = [];

  static var isPlaying = false;
  static var currentScreen = Screens.videoInit;

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
    required int videoInitItems,
    required int videoDescriptionItems,
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

    for (var i = 0; i < videoInitItems; i++) {
      videoInitControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      videoInitAnimation.add(
        _createAnimation(
          begin: Offset.zero,
          end: const Offset(-1, 0),
          parent: videoInitControllers[i],
        ),
      );
    }

    for (var i = 0; i < videoDescriptionItems; i++) {
      videoDescriptionControllers.add(
        AnimationController(
          vsync: vsync,
          duration: const Duration(milliseconds: 200),
        ),
      );

      videoDescriptionAnimation.add(
        _createAnimation(
          begin: const Offset(1, 0),
          end: Offset.zero,
          parent: videoDescriptionControllers[i],
        ),
      );
    }
  }

  static void dispose() {
    for (final controller in [
      topTextController,
      bottomTextController,
      ...videoInitControllers,
      ...videoDescriptionControllers,
    ]) {
      controller.dispose();
    }
  }

  static Future<void> forward() async {
    isPlaying = true;

    topTextController.forward();
    await bottomTextController.forward();

    for (final controller in [
      ...videoInitControllers,
      ...videoDescriptionControllers,
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
      ... videoDescriptionControllers.reversed,
      ...videoInitControllers.reversed,
    ]) {
      controller.reverse();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    bottomTextController.reverse();
    await topTextController.reverse();

    isPlaying = false;
  }
}
