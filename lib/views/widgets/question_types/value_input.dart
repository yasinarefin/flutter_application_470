import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/participation_status_controller.dart';
import 'package:flutter_application_470/controller/question_list_controller.dart';
import 'package:flutter_application_470/controller/question_types/value_input_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:get/get.dart';

class ValueInputQuestion extends StatefulWidget {
  final QuestionModel questionModel;
  final QuestionListController psc = Get.find();
  late ValueInputController valueInputController;
  ValueInputQuestion({required this.questionModel}) {
    //valueInputController = ValueInputController(questionModel: questionModel);
    valueInputController = psc.cons[questionModel.questionNo];
    print('done');
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: widget.valueInputController.saveButtonOn == true
                  ? () => widget.valueInputController.save(callback)
                  : null,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: widget.valueInputController.submitButtonOn == true
                  ? () => widget.valueInputController.submit(callback)
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
