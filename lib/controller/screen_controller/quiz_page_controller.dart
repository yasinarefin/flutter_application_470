import 'package:flutter_application_470/controller/question_controller/multiple_choice_controller.dart';
import 'package:flutter_application_470/controller/question_controller/single_choice_controller.dart';
import 'package:flutter_application_470/controller/question_controller/value_input_controller.dart';
import 'package:flutter_application_470/controller/user_controller/user_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/participation_model.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:get/get.dart';

class QuizPageController extends GetxController {
  final QuizModel quizModel;
  late ParticipationModel participationModel;
  final UserModelController uc = Get.find(); // get currently logged user.

  List<dynamic> questionControllers = [];
  List<QuestionModel> questions = [];
  QuizPageController({required this.quizModel});

  Future<int> getQuestions() async {
    ApiResponseModel response = await WebServices.getQuestions(
        uc.getUser().token, quizModel.quizId); // api call to load questions
    questions = response.data;
    // also load participation status for selected answers
    // ParticipationStatusController psc = ParticipationStatusController();
    //await psc.loadData(quizModel.quizId, quizModel);
    //Get.put(psc);

    await loadParticipation();
    for (QuestionModel q in questions) {
      if (q.type == 'sc') {
        questionControllers.add(SingleChoiceController(questionModel: q));
      } else if (q.type == 'mc') {
        questionControllers.add(MultipleChoiceController(questionModel: q));
      } else {
        questionControllers.add(ValueInputController(questionModel: q));
      }
    }
    return questions.isEmpty ? -1 : questions.length;
  }

  Future<void> loadParticipation() async {
    ApiResponseModel response = await WebServices.getParticipationStatus(
        uc.getUser().token, quizModel.quizId); // gets  a map
    if (response.statusCode == 200) {
      participationModel = response.data;
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

  // Future<void> loadData() async {
  //   var participationStatus = await WebServices.getParticipationStatus(
  //       uc.getUser().token, this.quizModel.quizId); // gets  a map
  //   if (!participationStatus.containsKey('error')) {
  //     participationModel = participationStatus['result'];
  //   } else {
  //     // otherwise initiate  a empty list
  //     participationModel = ParticipationModel(
  //       quizId: '',
  //       userEmail: '',
  //       submittedAnswers: [],
  //       savedAnswers: [],
  //       score: -1,
  //     );
  //   }
  // }

  // String getScore() {
  //   if (participationModel.score == -1) {
  //     return 'hidden';
  //   }
  //   return participationModel.score.toString();
  // }
}
