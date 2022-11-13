import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ocean_conservation_app/models/project_list_data.dart';
import 'package:ocean_conservation_app/utils/constants.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _nameHasError = false;
  bool _organizerHasError = false;
  bool _amountHasError = false;
  bool _descriptionHasError = false;
  String imageUrl = '';
  bool fundEnabled = true;

  void _onDateChanged(dynamic val) => debugPrint(val.toString());

  void _onSwitchChanged(dynamic val) => setState(() {
        fundEnabled = val;
      });

  @override
  void initState() {
    imageUrl =
        'https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6-300x188.png';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 163, 204, 255),
      appBar: AppBar(
          backgroundColor: kSecondaryColor,
          centerTitle: true,
          title: const Text('Add Project')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: 20.0),
            FormBuilder(
              key: _formKey,
              onChanged: () {
                _formKey.currentState!.save();
              },
              autovalidateMode: AutovalidateMode.disabled,
              initialValue: const {
                'name': 'Your project name',
                'organizer': 'Project organizer name',
                'amount': '0',
                'description': 'Project description'
              },
              skipDisabled: true,
              child: Column(children: <Widget>[
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'name',
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    suffixIcon: _nameHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                    prefixIcon: const Icon(Ionicons.newspaper_outline),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _nameHasError =
                          !(_formKey.currentState?.fields['name']?.validate() ??
                              false);
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(200),
                  ]),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'organizer',
                  decoration: InputDecoration(
                    labelText: 'Organizers Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    suffixIcon: _organizerHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                    prefixIcon: const Icon(Ionicons.person_outline),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _organizerHasError = !(_formKey
                              .currentState?.fields['organizer']
                              ?.validate() ??
                          false);
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(200),
                  ]),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                FormBuilderDateRangePicker(
                  name: 'date_range',
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2030),
                  format: DateFormat('yyyy-MM-dd'),
                  onChanged: _onDateChanged,
                  decoration: InputDecoration(
                    labelText: 'Project Start and End Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date_range']
                            ?.didChange(null);
                      },
                    ),
                    prefixIcon: const Icon(Ionicons.calendar_outline),
                  ),
                ),
                FormBuilderSwitch(
                  title: const Text('This is a funding project ( Yes / No )'),
                  name: 'fund',
                  initialValue: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: _onSwitchChanged,
                ),
                FormBuilderTextField(
                  enabled: fundEnabled,
                  autovalidateMode: AutovalidateMode.always,
                  name: 'amount',
                  decoration: InputDecoration(
                    labelText: 'Fund Amount',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    suffixIcon: _amountHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                    prefixIcon: const Icon(Ionicons.cash_outline),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _amountHasError = !(_formKey
                              .currentState?.fields['amount']
                              ?.validate() ??
                          false);
                    });
                  },
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()]),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20.0),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.always,
                  name: 'description',
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 225, 225, 225),
                    suffixIcon: _descriptionHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : null,
                  ),
                  onChanged: (val) {
                    setState(() {
                      _descriptionHasError = !(_formKey
                              .currentState?.fields['description']
                              ?.validate() ??
                          false);
                    });
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.max(200),
                  ]),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.next,
                  maxLines: 10,
                ),
              ]),
            ),
            const SizedBox(height: 20.0),
            Image.network(imageUrl),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text("Upload Image",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              onPressed: () {
                uploadImage();
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        submit();
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    // color: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  uploadImage() async {
    String imgName;
    final storageRef = FirebaseStorage.instance.ref();
    imgName =
        "${_formKey.currentState?.fields['name']?.value}_${FirebaseAuth.instance.currentUser!.uid}.jpg";
    final mountainsRef = storageRef.child(imgName);
    final mountainImagesRef = storageRef.child("images/$imgName");
    assert(mountainsRef.name == mountainImagesRef.name);
    assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

    final imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);

    try {
      await mountainsRef.putFile(file);
      var downloadUrl = await mountainsRef.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }

  Future submit() async {
    try {
      String? dateRange =
          _formKey.currentState?.fields['date_range']?.value.toString();

      final project = ProjectListData(
          uid: FirebaseAuth.instance.currentUser!.uid,
          imagePath: imageUrl,
          title: _formKey.currentState?.fields['name']?.value,
          description: _formKey.currentState?.fields['description']?.value,
          organizer: _formKey.currentState?.fields['organizer']?.value,
          startDate: dateRange != null ? dateRange.split(' - ').first : '',
          endDate: dateRange != null ? dateRange.split(' - ').last : '',
          fund: fundEnabled,
          fundAmount:
              int.parse(_formKey.currentState?.fields['amount']?.value));
      createProject(project);
      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future createProject(ProjectListData project) async {
    final docProject = FirebaseFirestore.instance.collection('projects').doc();
    project.id = docProject.id;
    final json = project.toJson();
    await docProject.set(json);
  }
}
