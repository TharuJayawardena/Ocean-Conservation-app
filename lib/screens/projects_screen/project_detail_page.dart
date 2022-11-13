import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ocean_conservation_app/models/project_list_data.dart';
import 'package:ocean_conservation_app/screens/home_screen/icons.dart';
import 'package:ocean_conservation_app/screens/home_screen/widgets/svg_asset.dart';
import 'package:ocean_conservation_app/screens/payment_screen/order_confirm_screen.dart';
import 'package:ocean_conservation_app/utils/constants.dart';
import 'package:ocean_conservation_app/widgets/hotel_app_theme.dart';
import 'dart:math' as math;
import '../login_screen/components/center_widget/center_widget.dart';

class ProjectDetailPage extends StatefulWidget {
  final ProjectListData project;

  const ProjectDetailPage({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
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
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: Hero(
                    tag: "sleepMeditation",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(widget.project.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Container(
                  height: 280,
                  width: 280,
                  padding: const EdgeInsets.all(30),
                  child: Image.network(
                    widget.project.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.person,
                              size: 25,
                              color:
                                  HotelAppTheme.buildLightTheme().primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.project.organizer,
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      const Color(0xffffffff).withOpacity(0.7)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.calendar,
                              size: 25,
                              color:
                                  HotelAppTheme.buildLightTheme().primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Start Date - ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      const Color(0xffffffff).withOpacity(0.7)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              formatDate(widget.project.startDate),
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      const Color(0xffffffff).withOpacity(0.7)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.calendar,
                              size: 25,
                              color:
                                  HotelAppTheme.buildLightTheme().primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'End Date  - ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      const Color(0xffffffff).withOpacity(0.7)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              formatDate(widget.project.endDate),
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      const Color(0xffffffff).withOpacity(0.7)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 25,
                              color:
                                  HotelAppTheme.buildLightTheme().primaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Rs.${widget.project.fundAmount}.00',
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      const Color(0xffffffff).withOpacity(0.7)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    )),
                const SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 28, right: 28, bottom: 80),
                  child: Text(
                    widget.project.description,
                    style: TextStyle(
                        color: const Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
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
            Visibility(
              visible: widget.project.fund,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 87,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      gradient: LinearGradient(
                          stops: [
                            0,
                            1
                          ],
                          colors: [
                            Color(0xff121421),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                  child: Center(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: onStartButtonPressed,
                        child: Ink(
                          decoration: BoxDecoration(
                            color: const Color(0xff4A80F0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            height: 56,
                            width: 319,
                            child: const Center(
                                child: Text(
                              "Fund",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String date) {
    return DateFormat.yMMMd()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(date));
  }

  void onStartButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderConfirmScreen()),
    );
  }

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
              Color.fromARGB(255, 131, 207, 255),
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
            Color.fromARGB(255, 131, 207, 255),
            Color(0x005CDBCF),
          ],
        ),
      ),
    );
  }
}
