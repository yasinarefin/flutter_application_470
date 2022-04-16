import 'package:flutter/cupertino.dart';
import 'package:flutter_application_470/controller/screen_controller/quiz_page_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

import '../user_controller/user_controller.dart';

class ValueInputController {
  final QuestionModel questionModel;
  final TextEditingController valueController =
      TextEditingController(); // holds text or value in the input box

  final UserModelController uc = Get.find();

  final QuizPageController psc = Get.find();

  bool submitButtonOn = true;
  bool saveButtonOn = true;
  ValueInputController({required this.questionModel}) {
    // update saved answers
    if (psc.participationModel.savedAnswers.isEmpty == false) {
      List<dynamic> c =
          psc.participationModel.savedAnswers[questionModel.questionNo];

      if (c.isEmpty == false) {
        valueController.text = c[0];
      }
    }

    // now disable buttons if already submitted
    if (psc.participationModel.submittedAnswers.isEmpty == false) {
      List<dynamic> c =
          psc.participationModel.submittedAnswers[questionModel.questionNo];
      if (c.isEmpty == false) {
        submitButtonOn = false;
        saveButtonOn = false;
      }
    }
  }
  void submit(Function callback) async {
    submitButtonOn = false;
    saveButtonOn = false;
    callback();

    ApiResponseModel response = await WebServices.submitAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      [valueController.text],
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
      [valueController.text],
    );

    if (response.statusCode != 200) {
      Get.snackbar('Error', 'Save ans failed');
    }
    saveButtonOn = true;
    callback();
  }
}
