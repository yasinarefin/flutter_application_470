import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:flutter_application_470/views/screens/home_page.dart';
import 'package:get/get.dart';

class QuestionListController {
  final QuizModel quizModel;
  final UserModelController uc = Get.find();
  QuestionListController({required this.quizModel}) {}
  Future<List<QuestionModel>> getQuestions() async {
    var list =
        await WebServices.getQuestions(uc.getUser().token, quizModel.quizId);
    return list;
  }
}
