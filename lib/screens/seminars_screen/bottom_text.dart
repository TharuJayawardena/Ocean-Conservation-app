import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper_functions.dart';
import 'seminars_add_screen.dart';
import 'seminars_screen_animation.dart';

class BottomText extends StatefulWidget {
  const BottomText({Key? key}) : super(key: key);

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    SeminarScreenAnimation.bottomTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: SeminarScreenAnimation.bottomTextAnimation,
      child: GestureDetector(
        onTap: () {
          if (!SeminarScreenAnimation.isPlaying) {
            SeminarScreenAnimation.currentScreen == Screens.seminarInit
                ? SeminarScreenAnimation.forward()
                : SeminarScreenAnimation.reverse();

            SeminarScreenAnimation.currentScreen =
                Screens.values[1 - SeminarScreenAnimation.currentScreen.index];
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
                  text: SeminarScreenAnimation.currentScreen ==
                          Screens.seminarInit
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
