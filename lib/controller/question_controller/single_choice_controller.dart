import 'package:flutter_application_470/controller/screen_controller/quiz_page_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:get/get.dart';

import '../user_controller/user_controller.dart';

class SingleChoiceController {
  final QuestionModel questionModel;
  final UserModelController uc = Get.find();
  final QuizPageController psc = Get.find();
  int selectedIndex = -1; // holds selected option index
  bool submitButtonOn = true;
  bool saveButtonOn = true;
  SingleChoiceController({required this.questionModel}) {
    // check if question is alread submitted
    if (psc.participationModel.savedAnswers.isEmpty == false) {
      List<dynamic> savedAns =
          psc.participationModel.savedAnswers[questionModel.questionNo];
      List<dynamic> submittedAns =
          psc.participationModel.submittedAnswers[questionModel.questionNo];
      if (savedAns.isEmpty == false) {
        selectedIndex = savedAns[0];
      }
      if (submittedAns.isEmpty == false) {
        submitButtonOn = false;
        saveButtonOn = false;
      }
    }
    print('okkkk');
  }

  void submit(Function callback) async {
    submitButtonOn = false;
    saveButtonOn = false;
    callback();

    ApiResponseModel response = await WebServices.submitAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      [selectedIndex],
    );

    if (response.statusCode != 200) {
      submitButtonOn = true;
      saveButtonOn = true;
      Get.snackbar('Error', response.data);
    }
    callback();
  }

  void save(Function callback) async {
    saveButtonOn = false;
    callback();

    ApiResponseModel response = await WebServices.saveAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      [selectedIndex],
    );

    if (response.statusCode != 200) {
      Get.snackbar('Error', 'Save ans failed');
    }
    saveButtonOn = true;
    callback();
  }
}
