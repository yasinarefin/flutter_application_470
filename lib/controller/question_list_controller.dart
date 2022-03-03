import 'package:flutter_application_470/controller/participation_status_controller.dart';
import 'package:flutter_application_470/controller/question_types/multiple_choice_controller.dart';
import 'package:flutter_application_470/controller/question_types/single_choice_controller.dart';
import 'package:flutter_application_470/controller/question_types/value_input_controller.dart';
import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

class QuestionListController extends GetxController {
  final QuizModel quizModel;
  final UserModelController uc = Get.find();
  List<dynamic> cons = [];
  QuestionListController({required this.quizModel}) {}

  Future<List<QuestionModel>> getQuestions() async {
    var list =
        await WebServices.getQuestions(uc.getUser().token, quizModel.quizId);

    // also load participation status for selected answers
    ParticipationStatusController psc = ParticipationStatusController();
    await psc.loadData(quizModel.quizId, quizModel);
    Get.put(psc);

    for (QuestionModel q in list) {
      if (q.type == 'sc') {
        cons.add(SingleChoiceController(questionModel: q));
      } else if (q.type == 'mc') {
        cons.add(MultipleChoiceController(questionModel: q));
      } else {
        cons.add(ValueInputController(questionModel: q));
      }
    }
    return list;
  }
}
