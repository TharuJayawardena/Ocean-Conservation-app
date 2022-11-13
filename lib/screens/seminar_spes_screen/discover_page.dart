import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ocean_conservation_app/screens/articles_screen/article_screen.dart';
import 'package:ocean_conservation_app/screens/projects_screen/project_screen.dart';
import 'package:ocean_conservation_app/screens/seminars_screen/seminars_screen.dart';
import 'package:ocean_conservation_app/screens/videos_Screen/video_screen.dart';
import 'dart:math' as math;
import '../login_screen/components/center_widget/center_widget.dart';
import 'details_page.dart';
import 'icons.dart';
import 'widgets/category_boxes.dart';
import 'widgets/discover_card.dart';
import 'widgets/discover_small_card.dart';
import 'widgets/svg_asset.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 18,
                top: 36,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Home",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Menu",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 19,
                    mainAxisExtent: 125,
                    mainAxisSpacing: 19),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DiscoverSmallCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArticleScreen()));
                    },
                    title: "Published Articles",
                    gradientStartColor: const Color(0xff13DEA0),
                    gradientEndColor: const Color(0xff06B782),
                    icon: const SvgAsset(
                      assetName: AssetName.article,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  DiscoverSmallCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SeminarScreen()));
                    },
                    title: "Scheduled Seminar List",
                    gradientStartColor: const Color.fromARGB(255, 249, 65, 255),
                    gradientEndColor: const Color(0xffF6815B),
                    icon: const SvgAsset(
                      assetName: AssetName.tape,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  DiscoverSmallCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VideoScreen()));
                    },
                    title: "Uploaded Recordings",
                    gradientStartColor: Color.fromARGB(255, 130, 196, 9),
                    gradientEndColor: Color.fromARGB(255, 50, 63, 3),
                    icon: const SvgAsset(
                      assetName: AssetName.tape,
                      height: 24,
                      width: 24,
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSeeAllTapped() {}

  void onSleepMeditationTapped() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const DetailsPage()));
  }

  void onDepressionHealingTapped() {}

  void onSearchIconTapped() {}
}
