import 'package:flutter/cupertino.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/controller/participation_status_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

import '../user_controller.dart';

class ValueInputController {
  final QuestionModel questionModel;
  final TextEditingController valueController = TextEditingController();
  final UserModelController uc = Get.find();
  final ParticipationStatusController psc = Get.find();
  bool submitButtonOn = true;
  ValueInputController({required this.questionModel}) {
    if (psc.selectedAnswers.isEmpty == false) {
      List<dynamic> c = psc.selectedAnswers[questionModel.questionNo];
      if (c.isEmpty == false) {
        submitButtonOn = false;
        valueController.text = c[0];
      }
    }
  }
  void submit(Function callback) async {
    submitButtonOn = false;
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
}
