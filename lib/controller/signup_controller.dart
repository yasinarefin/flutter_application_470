import 'package:flutter_application_470/models/sign_up_form.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignUpController {
  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  final signUpFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();

  void signUpEvent(Function callback) {
    if (signUpFormKey.currentState!.validate()) {
      callback();
      SignUpForm s = SignUpForm(
          email: emailController.text,
          username: userNameController.text,
          password: passwordController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text);
      Future<String> res = WebServices.signUp(s);
      res.then((value) {
        callback();
        if (value == 'ok') {
          Get.back();
          Get.snackbar('Signup status', 'User created succesfully');
        } else {
          Get.snackbar('Signup status', value);
        }
      });
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'email cannot be empty';
    } else if (!value.isEmail) {
      return 'Not an email!';
    } else {
      return null;
    }
  }

  String? validateUserName(String? value) {
    if (value!.length < 4) {
      return 'username must be at least 4 characters';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.length < 4) {
      return "password must be at least 4 characters";
    } else {
      return null;
    }
  }

  String? validateFirstName(String? value) {
    if (!validCharacters.hasMatch(value!)) {
      return "first name should be alphanumeric";
    } else {
      return null;
    }
  }

  String? validateLastName(String? value) {
    if (!validCharacters.hasMatch(value!)) {
      return "last name should be alphanumeric";
    } else {
      return null;
    }
  }
}
