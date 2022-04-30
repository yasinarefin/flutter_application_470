import 'package:flutter_application_470/controller/user_controller/user_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/user_model.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:flutter_application_470/utils/storage_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* this controller is used for initializing the logged in user  which will later be used  
all over the app */

class UserIntialize {
  // puts usermodel in getx controller
  static Future<bool> initUser() async {
    String? token = await StorageServices.getToken();

    if (token == null) return false;
    ApiResponseModel response = await WebServices.getUser(token);
    Map<String, String> user = response.data;

    if (user.containsKey('error')) {
      return false;
    }

    var model = UserModel(
        email: user['email'].toString(),
        username: user['user_name'].toString(),
        firstName: user['first_name'].toString(),
        lastName: user['last_name'].toString(),
        joiningDate: user['joining_date'].toString(),
        token: token.toString());
    Get.put(UserModelController());
    UserModelController f = Get.find();
    f.setUserModel(model);
    return true;
  }

  static Future<bool> initUserWeb() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) return false;
    ApiResponseModel response = await WebServices.getUser(token);
    Map<String, String> user = response.data;

    if (user.containsKey('error')) {
      return false;
    }

    var model = UserModel(
        email: user['email'].toString(),
        username: user['user_name'].toString(),
        firstName: user['first_name'].toString(),
        lastName: user['last_name'].toString(),
        joiningDate: user['joining_date'].toString(),
        token: token.toString());
    Get.put(UserModelController());
    UserModelController f = Get.find();
    f.setUserModel(model);
    return true;
  }
}
