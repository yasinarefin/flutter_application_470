import 'package:flutter_application_470/models/question_model.dart';

class MultipleChoiceController {
  final QuestionModel questionModel;
  late List<bool> checkBoxStates = [];
  MultipleChoiceController({required this.questionModel}) {
    for (int i = 0; i < questionModel.options.length; i++) {
      checkBoxStates.add(false);
    }
  }
}
