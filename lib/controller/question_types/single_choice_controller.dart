// import 'package:flutter_application_470/controller/participation_status_controller.dart';
// import 'package:flutter_application_470/models/question_model.dart';
// import 'package:flutter_application_470/services/web_services.dart';
// import 'package:get/get.dart';

// import '../user_controller.dart';

// class SingleChoiceController {
//   final QuestionModel questionModel;
//   final UserModelController uc = Get.find();
//   final ParticipationStatusController psc = Get.find();
//   RxInt selectedIndex = (-1.obs) as RxInt;
//   RxBool submitButtonOn = true.obs;
//   SingleChoiceController({required this.questionModel}) {
//     // check if question is alread submitted
//     if (psc.selectedAnswers.isEmpty == false) {
//       List<dynamic> c = psc.selectedAnswers[questionModel.questionNo];
//       if (c.isEmpty == false) {
//         submitButtonOn.value = false;
//         selectedIndex = c[0];
//       }
//     }
//   }

//   void submit() async {
//     submitButtonOn.value = false;
//     String response = await WebServices.submitAnswer(
//       uc.getUser().token,
//       questionModel.quizID,
//       questionModel.questionNo,
//       [selectedIndex],
//     );

//     if (response == 'ok') {
//     } else {
//       submitButtonOn.value = true;
//       Get.snackbar('Error', response);
//     }
//   }
// }

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
  }

  void submit(Function callback) async {
    submitButtonOn = false;
    saveButtonOn = false;
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
      saveButtonOn = true;
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
      [selectedIndex],
    );

    if (response == 'ok') {
    } else {
      Get.snackbar('Error', response);
    }
    saveButtonOn = true;
    callback();
  }
}
