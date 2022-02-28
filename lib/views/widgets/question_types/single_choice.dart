import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_types/single_choice_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';

class SingleChoiceQuestion extends StatefulWidget {
  final QuestionModel questionModel;
  late SingleChoiceController singleChoiceController;
  SingleChoiceQuestion({Key? key, required this.questionModel})
      : super(key: key) {
    singleChoiceController =
        SingleChoiceController(questionModel: questionModel);
  }
  @override
  _SingleChoiceQuestionState createState() => _SingleChoiceQuestionState();
}

class _SingleChoiceQuestionState extends State<SingleChoiceQuestion> {
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.questionModel.question),
        SingleChoiceOptions(
          singleChoiceController: widget.singleChoiceController,
        ),
        ElevatedButton(
          onPressed: widget.singleChoiceController.submitButtonOn
              ? () => widget.singleChoiceController.submit(callback)
              : null,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class SingleChoiceOptions extends StatefulWidget {
  final SingleChoiceController singleChoiceController;
  const SingleChoiceOptions({Key? key, required this.singleChoiceController})
      : super(key: key);

  @override
  State<SingleChoiceOptions> createState() => _SingleChoiceOptionsState();
}

class _SingleChoiceOptionsState extends State<SingleChoiceOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0;
            i < widget.singleChoiceController.questionModel.options.length;
            i++)
          ListTile(
            title: Text(widget.singleChoiceController.questionModel.options[i]),
            leading: Radio(
              value: i,
              groupValue: widget.singleChoiceController.selectedIndex,
              onChanged: (value) {
                setState(() {
                  widget.singleChoiceController.selectedIndex = value as int;
                });
              },
            ),
          ),
      ],
    );
  }
}
