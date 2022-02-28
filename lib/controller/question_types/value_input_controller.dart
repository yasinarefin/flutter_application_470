import 'package:flutter/cupertino.dart';
import 'package:flutter_application_470/models/question_model.dart';

class ValueInputController {
  final QuestionModel questionModel;
  final TextEditingController valueController = TextEditingController();
  ValueInputController({required this.questionModel});
}
