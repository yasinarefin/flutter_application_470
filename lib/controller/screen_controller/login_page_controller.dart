import 'package:flutter/material.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/controller/user_controller/user_init.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:flutter_application_470/views/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginController {
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passWordController = TextEditingController();

  void loginEvent(Function callback) async {
    if (loginFormKey.currentState!.validate()) {
      callback(); // update UI
      ApiResponseModel response = await WebServices.login(
          // api call for login
          emailController.text,
          passWordController.text);
      bool ok = response.data; // true if login successful

      // if (kIsWeb) return;

      if (ok) {
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
    }
    callback(); // update UI
  }
}
