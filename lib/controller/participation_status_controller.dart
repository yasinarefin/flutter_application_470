import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/participation_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

// this controller loads  participation status and saves it
class ParticipationStatusController extends GetxController {
  late QuizModel quizModel;
  late ParticipationModel participationModel;
  final UserModelController uc = Get.find();
  int totalScore = 0;
  Future<void> loadData(String quizId, QuizModel quizModel) async {
    this.quizModel = quizModel;
    var participationStatus = await WebServices.getParticipationStatus(
        uc.getUser().token, quizId); // gets  a map
    if (!participationStatus.containsKey('error')) {
      participationModel = participationStatus['result'];
    } else {
      // otherwise initiate  a empty list
      participationModel = ParticipationModel(
        quizId: '',
        userEmail: '',
        submittedAnswers: [],
        savedAnswers: [],
        score: -1,
      );
    }
  }

  String getScore() {
    if (participationModel.score == -1) {
      return 'hidden';
    }
    return participationModel.score.toString();
  }
}
