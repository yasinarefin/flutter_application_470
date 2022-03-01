import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

import '../participation_status_controller.dart';
import '../user_controller.dart';

class MultipleChoiceController {
  final QuestionModel questionModel;
  final List<bool> checkBoxStates = [];
  final ParticipationStatusController psc = Get.find();
  final UserModelController uc = Get.find();
  bool submitButtonOn = true;
  MultipleChoiceController({required this.questionModel}) {
    for (int i = 0; i < questionModel.options.length; i++) {
      checkBoxStates.add(false);
    }

    // check if question is alread submitted
    if (psc.selectedAnswers.isEmpty == false) {
      print(questionModel.questionNo);
      List<dynamic> c = psc.selectedAnswers[questionModel.questionNo];

      if (c.isEmpty == false) {
        submitButtonOn = false;
        for (int i in c) {
          checkBoxStates[i] = true;
        }
      }
    }
  }
  void submit(Function callback) async {
    submitButtonOn = false;
    callback();
    List<int> selectedAns = [];
    checkBoxStates.asMap().forEach((key, value) {
      if (value) {
        selectedAns.add(key);
      }
    });
    String response = await WebServices.submitAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      selectedAns,
    );

    if (response == 'ok') {
    } else {
      submitButtonOn = true;
      print('failed');
      Get.snackbar('Error', response);
    }
    callback();
  }
}
