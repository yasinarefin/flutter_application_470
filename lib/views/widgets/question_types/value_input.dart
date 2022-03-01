import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_types/value_input_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';

class ValueInputQuestion extends StatefulWidget {
  final QuestionModel questionModel;
  late ValueInputController valueInputController;
  ValueInputQuestion({required this.questionModel}) {
    valueInputController = ValueInputController(questionModel: questionModel);
  }

  @override
  _ValueInputQuestionState createState() => _ValueInputQuestionState();
}

class _ValueInputQuestionState extends State<ValueInputQuestion> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.valueInputController.questionModel.question),
        TextField(
          controller: widget.valueInputController.valueController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter ans',
          ),
        ),
        ElevatedButton(
          onPressed: widget.valueInputController.submitButtonOn
              ? () => widget.valueInputController.submit(callback)
              : null,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
