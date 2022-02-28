import 'package:flutter/material.dart';
import 'package:flutter_application_470/services/user_init.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:flutter_application_470/views/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginController {
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passWordController = TextEditingController();

  void loginEvent(Function callback) async {
    if (loginFormKey.currentState!.validate()) {
      callback();
      Future<bool> ok =
          WebServices.login(emailController.text, passWordController.text);

      // if (kIsWeb) return;

      ok.then((value) async {
        callback();
        if (value) {
          bool ok = kIsWeb
              ? await UserIntialize.initUserWeb()
              : await UserIntialize.initUser();
          if (ok) {
            Get.offNamed(HomePage.routeName);
            Get.snackbar('Login status', 'Login successful');
          } else {
            Get.snackbar('Login status', 'Login unsuccessful');
          }
        } else {
          Get.snackbar('Login status', 'Login unsuccessful');
        }
      });
    }
  }
}
