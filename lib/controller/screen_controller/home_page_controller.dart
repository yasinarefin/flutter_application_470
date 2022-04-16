import 'package:flutter_application_470/controller/user_controller/user_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:flutter_application_470/views/screens/login_page.dart';
import 'package:get/get.dart';

class HomePageController {
  final UserModelController uc = Get.find();
  late List<QuizModel> quizzes;

  Future<int> getQuizzes(String token, String status) async {
    ApiResponseModel response = await WebServices.getQuizzes(
        token, status); // api call to get list of quizzes
    if (response.statusCode == 200) {
      quizzes = response.data;
      return quizzes.length;
    }
    return -1;
  }

  QuizModel getQuizModel(int index) {
    return quizzes[index];
  }

  void handleClick(String option) async {
    if (option == 'Logout') {
      await WebServices.logOut(uc.getUser().token);
      Get.offNamed(LoginPage.routeName);
    }
  }
}
