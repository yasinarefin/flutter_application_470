import 'package:flutter_application_470/models/user_model.dart';
import 'package:get/get.dart';

/* this controller carries the Usermodel all accross the  app 
   we need usermodel all over the  app.
   For example auth token.
   Can be accessed anywhere to get logged in user
   final UserModelController uc = Get.find(); // get currently logged user.
*/
class UserModelController extends GetxController {
  late UserModel loggedUser;

  void setUserModel(UserModel userModel) {
    loggedUser = userModel;
  }

  UserModel getUser() {
    return loggedUser;
  }
}
