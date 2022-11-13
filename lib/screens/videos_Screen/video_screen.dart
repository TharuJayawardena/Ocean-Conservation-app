import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_conservation_app/models/vid_list_data.dart';
import 'package:ocean_conservation_app/models/video_list.dart';

import 'package:ocean_conservation_app/screens/seminar_spes_screen/videoDetails_page.dart';

import 'package:ocean_conservation_app/screens/videos_Screen/video_add_screen.dart';
import '../../utils/constants.dart';
import '../login_screen/components/center_widget/center_widget.dart';

import '../../widgets/hotel_app_theme.dart';
import '../../models/vid_list_data.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<VidListData> vidList = VidListData.vidList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: <Widget>[
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
          const SizedBox(height: 50),
          NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    title: const Text(
                      'Videos',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                    floating: false,
                    expandedHeight: 0,
                    centerTitle: true,
                    forceElevated: innerBoxIsScrolled,
                    backgroundColor: kSecondaryColor,
                    actions: [
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddVideoScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ];
              },
              body: StreamBuilder<List<VideoListData>>(
                  stream: readData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something Wrong');
                    } else {
                      var videos = snapshot.data;
                      var dummy = [VideoListData(), VideoListData()];

                      return ListView(
                        children: videos?.map(videosWidget).toList() ??
                            dummy.map(buildUser).toList(),
                      );
                    }
                  })),
        ],
      ),
    );
  }

  String formatDate(String date) {
    return DateFormat.yMMMd()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(date));
  }

  String formatTime(String date) {
    return DateFormat.jm()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(date));
  }

  Widget videosWidget(VideoListData videos) => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(
                          videos.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: HotelAppTheme.buildLightTheme().backgroundColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 5, bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      videos.title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.person,
                                          size: 15,
                                          color: HotelAppTheme.buildLightTheme()
                                              .primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          videos.speaker,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                              Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.link,
                                          size: 15,
                                          color: HotelAppTheme.buildLightTheme()
                                              .primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          videos.videoUrl,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                              Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: HotelAppTheme.buildLightTheme()
                                              .primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Upload Date - ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          formatDate(videos.uploadDate),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 15,
                                          color: HotelAppTheme.buildLightTheme()
                                              .primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Expire Date  - ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          formatDate(videos.expireDate),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 172,
                              child: TextButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ))),
                                  onPressed: onViewPressed,
                                  child: const Text('View Details')),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: HotelAppTheme.buildLightTheme().primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildUser(VideoListData videos) => ListTile(
        title: Text(videos.title),
    subtitle: Text(videos.speaker),

      );

  void onViewPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VideoDetailsPage()),
    );
  }


  Stream<List<VideoListData>> readData() => FirebaseFirestore.instance
      .collection('videos')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => VideoListData.fromJson(doc.data()))
          .toList());

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

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
