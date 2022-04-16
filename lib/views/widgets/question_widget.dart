import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/screen_controller/quiz_page_controller.dart';
import 'package:flutter_application_470/views/widgets/question_types/multiple_choice.dart';
import 'package:flutter_application_470/views/widgets/question_types/single_choice.dart';
import 'package:flutter_application_470/views/widgets/question_types/value_input.dart';
import 'package:get/get.dart';

class QuizQuestion extends StatelessWidget {
  final int questionNo;
  final QuizPageController quizPageController = Get.find();
  QuizQuestion({Key? key, required this.questionNo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (quizPageController.questions[questionNo].type == 'sc') {
      return SingleChoiceQuestion(
        singleChoiceController:
            quizPageController.questionControllers[questionNo],
      );
    } else if (quizPageController.questions[questionNo].type == 'mc') {
      return MultipleChoiceQuestion(
        multipleChoiceController:
            quizPageController.questionControllers[questionNo],
      );
    }

    //otherwise it's a value input question
    return ValueInputQuestion(
      valueInputController: quizPageController.questionControllers[questionNo],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_application_470/controller/screen_controller/quiz_page_controller.dart';
// import 'package:flutter_application_470/models/question_model.dart';
// import 'package:flutter_application_470/views/widgets/question_types/multiple_choice.dart';
// import 'package:flutter_application_470/views/widgets/question_types/single_choice.dart';
// import 'package:flutter_application_470/views/widgets/question_types/value_input.dart';
// import 'package:get/get.dart';

// class QuizQuestion extends StatelessWidget {
//   final QuestionModel question;
//   final QuizPageController quizPageController = Get.find();
//   QuizQuestion({Key? key, required this.question}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     if (question.type == 'sc') {
//       return SingleChoiceQuestion(
//         singleChoiceController:
//             quizPageController.questionControllers[question.questionNo],
//       );
//     } else if (question.type == 'mc') {
//       return MultipleChoiceQuestion(
//         multipleChoiceController:
//             quizPageController.questionControllers[question.questionNo],
//       );
//     }

//     //otherwise it's a value input question
//     return ValueInputQuestion(
//       valueInputController:
//           quizPageController.questionControllers[question.questionNo],
//     );
//   }
// }
