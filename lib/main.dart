import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/user_controller/user_init.dart';
import 'package:flutter_application_470/views/screens/home_page.dart';
import 'package:flutter_application_470/views/screens/login_page.dart';
import 'package:flutter_application_470/views/screens/quiz_page.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuild(),
      getPages: [
        GetPage(
          name: LoginPage.routeName,
          page: () => LoginPage(),
        ),
        GetPage(
          name: HomePage.routeName,
          page: () => HomePage(),
        ),
        GetPage(
          name: QuizPage.routeName,
          page: () => QuizPage(),
        ) // // Dynamic route
      ],
    );
  }
}

class FutureBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: kIsWeb ? UserIntialize.initUserWeb() : UserIntialize.initUser(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || !snapshot.hasData) {
              return LoginPage();
            } else if (snapshot.data == true) {
              return HomePage();
            } else {
              return LoginPage();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
