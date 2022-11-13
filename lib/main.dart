import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ocean_conservation_app/middlewares/AuthMiddleWare.dart';
import 'package:ocean_conservation_app/screens/home_screen/home_page.dart';
import 'package:ocean_conservation_app/screens/login_screen/login_screen.dart';
import 'package:ocean_conservation_app/screens/projects_screen/project_screen.dart';
import 'package:ocean_conservation_app/screens/todo_screen/data/services/storage/sevices.dart';
import 'package:ocean_conservation_app/middlewares/TodoMiddleWare.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/home/binding.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/home/widgets/demopagestate.dart';
import 'package:ocean_conservation_app/screens/todo_screen/screen/intro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ocean_conservation_app/utils/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

SharedPreferences? preferences;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await GetStorage.init();
  await Get.putAsync(() => StoreService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OCEAN CONSERVATION APP',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 32,
                fontFamily: "Ubuntu-Medium.ttf",
                color: Colors.black),
            headline2: TextStyle(
                fontSize: 17,
                fontFamily: "Ubuntu-Regular.ttf",
                color: Colors.black54),
            headline3: TextStyle(
                fontSize: 24,
                fontFamily: "Ubuntu-Medium.ttf",
                color: Colors.white),
            headline4: TextStyle(
                fontSize: 36,
                fontFamily: "Ubuntu-Medium.ttf",
                color: Colors.black,
                fontWeight: FontWeight.w500),
            headline5: TextStyle(
                fontSize: 24,
                fontFamily: "Ubuntu-Medium.ttf",
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w500),
            // button: TextStyle(
            //     fontSize: 25,
            //     fontFamily: "Ubuntu-Medium.ttf",
            //     color: Colors.deepPurple),
            headline6: TextStyle(
                fontSize: 25,
                fontFamily: "Ubuntu-Medium.ttf",
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ).apply(fontFamily: "Ubuntu")),
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen(), middlewares: [AuthMeddleWare()]),
        GetPage(name: '/Home', page: () => const HomePage()),
        GetPage(name: '/TodoIntro', page: () => Intro(), middlewares: [IntroMeddleWare()]),
        GetPage(name: '/Todo', page: () => Demopagestate()),
        GetPage(name: '/Projects', page: () => const ProductScreen()),
      ],
      home: const LoginScreen(),
    );
  }
}
