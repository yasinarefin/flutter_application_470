import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/views/widgets/question_types/multiple_choice.dart';
import 'package:flutter_application_470/views/widgets/question_types/single_choice.dart';
import 'package:flutter_application_470/views/widgets/question_types/value_input.dart';

class QuizQuestion extends StatelessWidget {
  final QuestionModel question;
  QuizQuestion({Key? key, required this.question}) : super(key: key);
  final QuestionController _questionController = QuestionController();
  @override
  Widget build(BuildContext context) {
    if (question.type == 'sc') {
      return SingleChoiceQuestion(questionModel: question);
    } else if (question.type == 'mc') {
      return MultipleChoiceQuestion(questionModel: question);
    }
    return ValueInputQuestion(
      questionModel: question,
    );
    //otherwise it's a value input question
  }
}
