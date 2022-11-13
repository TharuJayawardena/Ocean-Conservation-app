import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/helper_functions.dart';
import 'article_add_screen.dart';
import 'article_screen_animation.dart';

class BottomText extends StatefulWidget {
  const BottomText({Key? key}) : super(key: key);

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    ArticleScreenAnimation.bottomTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ArticleScreenAnimation.bottomTextAnimation,
      child: GestureDetector(
        onTap: () {
          if (!ArticleScreenAnimation.isPlaying) {
            ArticleScreenAnimation.currentScreen == Screens.articleInit
                ? ArticleScreenAnimation.forward()
                : ArticleScreenAnimation.reverse();

            ArticleScreenAnimation.currentScreen =
                Screens.values[1 - ArticleScreenAnimation.currentScreen.index];
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
                  text:ArticleScreenAnimation.currentScreen ==
                          Screens.articleInit
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
