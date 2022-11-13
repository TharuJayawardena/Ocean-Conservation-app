import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_conservation_app/models/video_list.dart';
import 'package:ocean_conservation_app/widgets/calendar_popup_view.dart';
import '../../utils/constants.dart';
import 'dart:math' as math;
import '../../utils/helper_functions.dart';
import '../login_screen/components/center_widget/center_widget.dart';
import 'package:intl/intl.dart';

import 'bottom_text.dart';
import 'video_screen.dart';
import 'video_screen_animation.dart';

enum Screens { videoInit, videoDescription }

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen>
    with TickerProviderStateMixin {
  late final List<Widget> videoInit;
  late final List<Widget> videoDescription;



  late final TextEditingController  name ;
  late final TextEditingController  speaker ;
  late final TextEditingController  videoUrl ;
  late final TextEditingController description ;
  late final TextEditingController  imagePath ;

  final _nameKey = GlobalKey<FormFieldState>();
  final _speakerKey = GlobalKey<FormFieldState>();
  final _videoUrlKey =  GlobalKey<FormFieldState>();
  final _descriptionKey = GlobalKey<FormFieldState>();
  final _imagePathKey = GlobalKey<FormFieldState>();


  DateTime uploadDate = DateTime.now();
  DateTime expireDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
     name = TextEditingController();
     speaker = TextEditingController();
     videoUrl = TextEditingController();
     description = TextEditingController();
     imagePath = TextEditingController();
    videoInit = [
      inputField(
          'Video Topic', Ionicons.newspaper_outline, name, TextInputType.name,_nameKey),
      inputField('Speaker Name', Ionicons.person_outline, speaker,
          TextInputType.name, _speakerKey),
      inputField(
          'Video URL', Ionicons.link_outline, videoUrl, TextInputType.name,_videoUrlKey),

      getTimeDateUI(),

    ];

    videoDescription = [
      inputMulti('Description', Ionicons.menu_outline, description,
          TextInputType.multiline, _descriptionKey),
      inputMulti('Image URL', Ionicons.image_outline, imagePath,
          TextInputType.multiline, _imagePathKey),
      loginButton('Submit', submit),
    ];

    VideoScreenAnimation.initialize(
      vsync: this,
      videoInitItems:videoInit.length,
      videoDescriptionItems: videoDescription.length,
    );

    for (var i = 0; i < videoInit.length; i++) {
      videoInit[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: VideoScreenAnimation.videoInitAnimation[i],
        child: videoInit[i],
      );
    }

    for (var i = 0; i < videoDescription.length; i++) {
      videoDescription[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: VideoScreenAnimation.videoDescriptionAnimation[i],
        child: videoDescription[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    speaker.dispose();
    videoUrl.dispose();
    description.dispose();
    imagePath.dispose();
    VideoScreenAnimation.dispose();



    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          centerTitle: true,
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Add Video',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white),
          )),
      body: Stack(
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
          const Positioned(
            top: 25,
            left: 24,
            child: Text(
              'New Video',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: videoInit,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: videoDescription,
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: BottomText(),
            ),
          ),
        ],
      ),
    );
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

  Widget inputField(String hint, IconData iconData,
      TextEditingController? controller, TextInputType type,GlobalKey<FormFieldState> key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          key: key,
          keyboardType: type,
          controller: controller,
          textAlignVertical: TextAlignVertical.bottom,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            prefixIcon: Icon(iconData),
          ),
        ),
      ),
    );
  }

  Widget inputMulti(String hint, IconData iconData,
      TextEditingController? controller, TextInputType type,  GlobalKey<FormFieldState> key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          key: key,
          keyboardType: type,
          controller: controller,
          maxLines: 5,
          minLines: 1,
          textAlignVertical: TextAlignVertical.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            prefixIcon: Icon(iconData),
          ),
        ),
      ),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.grey.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            showDemoDialog(context: context);
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
            child: SizedBox(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Ionicons.calendar_clear_outline,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Start ${DateFormat("dd, MMM").format(uploadDate)} - End ${DateFormat("dd, MMM").format(expireDate)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        maximumDate: DateTime(
            DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
        initialEndDate: expireDate,
        initialStartDate: uploadDate,
        onApplyClick: (DateTime uploadData, DateTime expireData) {
          setState(() {
            uploadDate = uploadData;
            expireDate = expireData;
          });

          print(uploadData);
          print(expireData);
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget loginButton(String title, void Function()? function) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          primary: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future submit() async {
    try {
      _nameKey.currentState!.validate();
      _speakerKey.currentState!.validate();
      _videoUrlKey.currentState!.validate();
      _descriptionKey.currentState!.validate();
      _imagePathKey.currentState!.validate();

      if (_nameKey.currentState!.validate() &&
          _speakerKey.currentState!.validate() &&
          _videoUrlKey.currentState!.validate() &&
          _descriptionKey.currentState!.validate() &&
          _imagePathKey.currentState!.validate()  ) {
        final video = VideoListData(
            imagePath: imagePath.text,
            title: name.text,
            description: description.text,
            speaker: speaker.text,
            videoUrl: videoUrl.text,
            uploadDate: uploadDate.toString(),
            expireDate: expireDate.toString(),
           );


        createVideo(video);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VideoScreen()));
      } else {
        displayMessage('One or more validation error occurred');
      }
    }catch (e) {
      displayMessage('Error');
    }
  }


  Future createVideo(VideoListData video) async {
    final docVideo = FirebaseFirestore.instance.collection('videos').doc();
    video.id = docVideo.id;
    final json = video.toJson();
    await docVideo.set(json);
  }

  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      content: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Oops Error!',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        message,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 25,
              left: 20,
              child: ClipRRect(
                child: Stack(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.red.shade200,
                      size: 17,
                    )
                  ],
                ),
              )),
          Positioned(
              top: -20,
              left: 5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  const Positioned(
                      top: 5,
                      child: Icon(
                        Icons.clear_outlined,
                        color: Colors.white,
                        size: 20,
                      ))
                ],
              )),
        ],
      ),
    ));
  }
}
