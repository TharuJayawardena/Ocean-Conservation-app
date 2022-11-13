import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper_functions.dart';
import 'video_add_screen.dart';
import 'video_screen_animation.dart';

class BottomText extends StatefulWidget {
  const BottomText({Key? key}) : super(key: key);

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    VideoScreenAnimation.bottomTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: VideoScreenAnimation.bottomTextAnimation,
      child: GestureDetector(
        onTap: () {
          if (!VideoScreenAnimation.isPlaying) {
            VideoScreenAnimation.currentScreen == Screens.videoInit
                ? VideoScreenAnimation.forward()
                : VideoScreenAnimation.reverse();

            VideoScreenAnimation.currentScreen =
                Screens.values[1 - VideoScreenAnimation.currentScreen.index];
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
              ),
              children: [
                TextSpan(
                  text: VideoScreenAnimation.currentScreen ==
                          Screens.videoInit
                      ? 'Continue '
                      : 'Back ',
                  style: const TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // TextSpan(
                //   text: ProjectScreenAnimation.currentScreen ==
                //           Screens.projectDescription
                //       ? 'Log In'
                //       : 'Sign Up',
                //   style: const TextStyle(
                //     color: kSecondaryColor,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
