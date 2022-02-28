import 'package:flutter_application_470/models/user_model.dart';
import 'package:get/get.dart';

class UserModelController extends GetxController {
  late UserModel loggedUser;

  void setUserModel(UserModel userModel) {
    loggedUser = userModel;
  }

  UserModel getUser() {
    return loggedUser;
  }
}
