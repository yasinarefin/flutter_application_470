import 'package:flutter_application_470/controller/question_types/multiple_choice_controller.dart';
import 'package:flutter_application_470/controller/question_types/single_choice_controller.dart';
import 'package:flutter_application_470/controller/question_types/value_input_controller.dart';
import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';
import 'package:flutter_application_470/models/question_model.dart';

// this controller loads  participation status and saves it
class ParticipationStatusController extends GetxController {
  late QuizModel quizModel;
  Map<String, dynamic> participationStatus = {};
  List<dynamic> selectedAnswers = [];
  final UserModelController uc = Get.find();
  int totalScore = 0;
  Future<void> loadData(String quizId, QuizModel quizModel) async {
    this.quizModel = quizModel;
    participationStatus =
        await WebServices.getParticipationStatus(uc.getUser().token, quizId);

    if (!participationStatus.containsKey('error')) {
      selectedAnswers = participationStatus['answers'];
    }
  }

  String getScore() {
    if (participationStatus['score'] == -1) {
      return 'hidden';
    }
    return participationStatus['score'].toString();
  }
}
