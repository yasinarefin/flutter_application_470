import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_list_controller.dart';
import 'package:flutter_application_470/controller/question_types/multiple_choice_controller.dart';
import 'package:flutter_application_470/controller/question_types/single_choice_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:get/get.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final QuestionModel questionModel;
  late MultipleChoiceController multiChoiceController;
  final QuestionListController questionListController = Get.find();
  MultipleChoiceQuestion({Key? key, required this.questionModel})
      : super(key: key) {
    multiChoiceController =
        questionListController.cons[questionModel.questionNo];
    //multiChoiceController =
    //MultipleChoiceController(questionModel: questionModel);
  }
  @override
  _MultipleChoiceQuestionState createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.questionModel.question),
        MultipleChoiceOptions(
          multipleChoiceController: widget.multiChoiceController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: widget.multiChoiceController.saveButtonOn == true
                  ? () => widget.multiChoiceController.save(callback)
                  : null,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: widget.multiChoiceController.submitButtonOn == true
                  ? () => widget.multiChoiceController.submit(callback)
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}

class MultipleChoiceOptions extends StatefulWidget {
  final MultipleChoiceController multipleChoiceController;
  const MultipleChoiceOptions(
      {Key? key, required this.multipleChoiceController})
      : super(key: key);

  @override
  _MultipleChoiceOptionsState createState() => _MultipleChoiceOptionsState();
}

class _MultipleChoiceOptionsState extends State<MultipleChoiceOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0;
            i < widget.multipleChoiceController.questionModel.options.length;
            i++)
          CheckboxListTile(
            title:
                Text(widget.multipleChoiceController.questionModel.options[i]),
            value: widget.multipleChoiceController.checkBoxStates[i],
            onChanged: (newValue) {
              setState(() {
                widget.multipleChoiceController.checkBoxStates[i] =
                    newValue as bool;
              });
            },
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
      ],
    );
  }
}
