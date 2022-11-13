import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_conservation_app/models/seminar_list.dart';
import 'package:ocean_conservation_app/widgets/calendar_popup_view.dart';
import '../../utils/constants.dart';
import 'dart:math' as math;
import '../../utils/helper_functions.dart';
import '../login_screen/components/center_widget/center_widget.dart';
import 'package:intl/intl.dart';

import 'bottom_text.dart';
import 'seminars_screen.dart';
import 'seminars_screen_animation.dart';

enum Screens { seminarInit, seminarDescription }

class AddSeminarScreen extends StatefulWidget {
  const AddSeminarScreen({Key? key}) : super(key: key);

  @override
  State<AddSeminarScreen> createState() => _AddSeminarScreenState();
}

class _AddSeminarScreenState extends State<AddSeminarScreen>
    with TickerProviderStateMixin {
  late final List<Widget> seminarInit;
  late final List<Widget> seminarDescription;

  final name = TextEditingController();
  final organizer = TextEditingController();
  final description = TextEditingController();
  final meetingLink = TextEditingController();
  final _nameKey = GlobalKey<FormFieldState>();
  final _organizerKey = GlobalKey<FormFieldState>();
  final _descriptionKey = GlobalKey<FormFieldState>();
  final _meetingLinkKey = GlobalKey<FormFieldState>();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  TextEditingController timeInput = TextEditingController();

  @override
  void initState() {
    timeInput.text = DateFormat("hh:mm a").format(DateTime.now());
    seminarInit = [
      inputField('Topic', Ionicons.newspaper_outline, name, TextInputType.name,
          _nameKey),
      inputField('Organizers Name', Ionicons.person_outline, organizer,
          TextInputType.name, _organizerKey),
      inputField('Meeting Link', Ionicons.link_outline, meetingLink, TextInputType.name,
          _meetingLinkKey),
      getTimeDateUI(),
      timePicker()
    ];

    seminarDescription = [
      inputMulti('Description', Ionicons.menu_outline, description,
          TextInputType.multiline, _descriptionKey),
      loginButton('Submit', submit),
    ];

    SeminarScreenAnimation.initialize(
      vsync: this,
      seminarInitItems: seminarInit.length,
      seminarDescriptionItems: seminarDescription.length,
    );

    for (var i = 0; i < seminarInit.length; i++) {
      seminarInit[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: SeminarScreenAnimation.seminarInitAnimation[i],
        child: seminarInit[i],
      );
    }

    for (var i = 0; i < seminarDescription.length; i++) {
      seminarDescription[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: SeminarScreenAnimation.seminarDescriptionAnimation[i],
        child: seminarDescription[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    SeminarScreenAnimation.dispose();
    name.dispose();
    organizer.dispose();
    description.dispose();
    meetingLink.dispose();

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
            'Add Seminar',
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
              'New Seminar',
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
                  children: seminarInit,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: seminarDescription,
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

  Widget inputField(
      String hint,
      IconData iconData,
      TextEditingController? controller,
      TextInputType type,
      GlobalKey<FormFieldState> key) {
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

  Widget inputMulti(
      String hint,
      IconData iconData,
      TextEditingController? controller,
      TextInputType type,
      GlobalKey<FormFieldState> key) {
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
              return 'Please enter some text';
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

  Widget timePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextField(
          keyboardType: TextInputType.name,
          controller: timeInput,
          maxLines: 5,
          minLines: 1,
          textAlignVertical: TextAlignVertical.center,
          readOnly: true,
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            if (pickedTime != null) {
              setState(() {
                timeInput.text = pickedTime.format(context);
              });
            } else {}
          },
          decoration: InputDecoration(
            labelText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Select Time',
            prefixIcon: const Icon(Ionicons.time_outline),
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
          onTap: () async {
            // FocusScope.of(context).requestFocus(FocusNode());
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100));

            if (pickedDate != null) {
              setState(() {
                startDate = pickedDate;
                endDate = pickedDate;
              });
            } else {}
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
                        DateFormat("dd, MMM").format(startDate),
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

  // void showDemoDialog({BuildContext? context}) {
  //   showDialog<dynamic>(
  //     context: context!,
  //     builder: (BuildContext context) => CalendarPopupView(
  //       barrierDismissible: false,
  //       minimumDate: DateTime.now(),
  //       maximumDate: DateTime(
  //           DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
  //       initialEndDate: startDate,
  //       initialStartDate: startDate,
  //       onApplyClick: (DateTime startData, DateTime endData) {
  //         setState(() {
  //           startDate = startData;
  //           endDate = endData;
  //         });
  //       },
  //       onCancelClick: () {},
  //     ),
  //   );
  // }

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
      _organizerKey.currentState!.validate();
      _descriptionKey.currentState!.validate();
      _meetingLinkKey.currentState!.validate();

      if (_nameKey.currentState!.validate() &&
          _organizerKey.currentState!.validate() &&
          _descriptionKey.currentState!.validate() &&
          _meetingLinkKey.currentState!.validate()) {
        final seminar = SeminarListData(
            meetingLink: meetingLink.text,
            title: name.text,
            description: description.text,
            organizer: organizer.text,
            startDate: startDate.toString(),
            startTime: timeInput.text,
            endDate: endDate.toString());

        createSeminar(seminar);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SeminarScreen()));
      } else {
        displayMessage('One or more validation error occurred');
      }
    } catch (e) {
      displayMessage('Error');
    }
  }

  Future createSeminar(SeminarListData seminar) async {
    final docSeminar = FirebaseFirestore.instance.collection('seminars').doc();
    seminar.id = docSeminar.id;
    final json = seminar.toJson();
    await docSeminar.set(json);
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
