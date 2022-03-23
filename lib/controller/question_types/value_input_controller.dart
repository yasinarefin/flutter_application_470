import 'package:flutter/cupertino.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/controller/participation_status_controller.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

import '../user_controller.dart';

class ValueInputController {
  final QuestionModel questionModel;
  final TextEditingController valueController = TextEditingController();
  final UserModelController uc = Get.find();
  final ParticipationStatusController psc = Get.find();
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

    String response = await WebServices.submitAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      [valueController.text],
    );

    if (response == 'ok') {
    } else {
      submitButtonOn = true;
      Get.snackbar('Error', response);
    }
    callback();
  }

  void save(Function callback) async {
    saveButtonOn = false;
    callback();

    String response = await WebServices.savedAnswer(
      uc.getUser().token,
      questionModel.quizID,
      questionModel.questionNo,
      [valueController.text],
    );

    if (response == 'ok') {
    } else {
      Get.snackbar('Error', response);
    }
    saveButtonOn = true;
    callback();
  }
}
