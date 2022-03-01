import 'package:flutter_application_470/controller/participation_status_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

import '../user_controller.dart';

class SingleChoiceController {
  final QuestionModel questionModel;
  final UserModelController uc = Get.find();
  final ParticipationStatusController psc = Get.find();
  int selectedIndex = -1;
  bool submitButtonOn = true;
  SingleChoiceController({required this.questionModel});

  void init() {
    if (psc.selectedAnswers.isEmpty == false) {
      List<dynamic> c = psc.selectedAnswers[questionModel.questionNo];
      if (c.isEmpty == false) {
        submitButtonOn = false;
        selectedIndex = c[0];
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
      [selectedIndex],
    );

    if (response == 'ok') {
    } else {
      submitButtonOn = true;
      Get.snackbar('Error', response);
    }
    callback();
  }
}
