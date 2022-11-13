import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ocean_conservation_app/utils/constants.dart';
import 'dart:math' as math;
import '../login_screen/components/center_widget/center_widget.dart';
import 'icons.dart';
import 'widgets/svg_asset.dart';

class VideoDetailsPage extends StatefulWidget {
  const VideoDetailsPage({Key? key}) : super(key: key);

  @override
  _VideoDetailsPageState createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -160,
              left: -30,
              child: topWidget(screenSize.width),
            ),
            Positioned(
              bottom: -180,
              left: -40,
              child: bottomWidget(screenSize.width),
            ),
            CenterWidget(size: screenSize),
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 66,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Hero(
                    tag: "Recorded Seminars",
                    child: Material(
                      color: Colors.transparent,
                      child: Text("Description About Video",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Text(
                    "Below is the breif description about the topic which we plan to discuss in the seminar.",
                    style: TextStyle(

                        color: const Color(0xffffff).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 279,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 28),
                      Container(
                        height: 280,
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/pics/pic1.png"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Container(
                      //   height: 280,
                      //   width: 280,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(20),
                      //     image: const DecorationImage(
                      //       fit: BoxFit.cover,
                      //       image: AssetImage(
                      //         "assets/pics/pic2.jpg",
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),


                const SizedBox(height: 46),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 28, right: 28, bottom: 80),
                  child: Text(
                    "Marine Conservation Institute is a tax-exempt nonprofit ocean conservation organization working to identify and protect vulnerable ocean ecosystems worldwide. The organization is headquartered in Seattle, Washington with offices in Washington D.C. and Glen Ellen, California.",
                    style: TextStyle(
                        color: const Color(0x000000).withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: kSecondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 22, right: 22, top: 10, bottom: 10),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onBackIconTapped,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: const Center(
                                child: SvgAsset(
                                  assetName: AssetName.back,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onHeartIconTapped,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Center(
                                child: SvgAsset(
                                  assetName: AssetName.heart,
                                  height: 24,
                                  width: 24,
                                  color: isHeartIconTapped!
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

          ],
        ),
      ),
    );
  }

  void onStartButtonPressed() {}

  void onBackIconTapped() {
    Navigator.pop(context);
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color(0xB316BFC4),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            Color(0xDB4BE8CC),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }
}
