import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/user_model.dart';
import 'package:flutter_application_470/services/storage_services.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:flutter_application_470/views/screens/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserIntialize {
  // puts usermodel in getx controller
  static Future<bool> initUser() async {
    String? token = await StorageServices.getToken();

    if (token == null) return false;
    Map<String, String> user = await WebServices.getUser(token);

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
    Map<String, String> user = await WebServices.getUser(token);

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
    //Get.offNamed(HomePage.routeName);
    // Get.snackbar('Login status', 'Login successful');
    return true;
  }
}
