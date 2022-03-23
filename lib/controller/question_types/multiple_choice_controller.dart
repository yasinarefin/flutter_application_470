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
  bool saveButtonOn = true;
  MultipleChoiceController({required this.questionModel}) {
    for (int i = 0; i < questionModel.options.length; i++) {
      checkBoxStates.add(false);
    }
    // update saved answers
    if (psc.participationModel.savedAnswers.isEmpty == false) {
      List<dynamic> c =
          psc.participationModel.savedAnswers[questionModel.questionNo];

      if (c.isEmpty == false) {
        for (int i in c) {
          checkBoxStates[i] = true;
        }
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

  void save(Function callback) async {
    saveButtonOn = false;
    callback();

    List<int> selectedAns = [];
    checkBoxStates.asMap().forEach((key, value) {
      if (value) {
        selectedAns.add(key);
      }
    });

    String response = await WebServices.savedAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      selectedAns,
    );

    if (response == 'ok') {
    } else {
      Get.snackbar('Error', response);
    }
    saveButtonOn = true;
    callback();
  }
}
