import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_controller/single_choice_controller.dart';

class SingleChoiceQuestion extends StatefulWidget {
  late SingleChoiceController singleChoiceController;
  SingleChoiceQuestion({Key? key, required this.singleChoiceController})
      : super(key: key);
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
        Text(widget
            .singleChoiceController.questionModel.question), // question text
        Column(
          // options
          children: [
            for (int i = 0;
                i < widget.singleChoiceController.questionModel.options.length;
                i++)
              ListTile(
                title: Text(
                    widget.singleChoiceController.questionModel.options[i]),
                leading: Radio(
                  value: i,
                  groupValue: widget.singleChoiceController.selectedIndex,
                  onChanged: (value) {
                    setState(() {
                      widget.singleChoiceController.selectedIndex =
                          value as int;
                    });
                  },
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: widget.singleChoiceController.saveButtonOn == true
                  ? () => widget.singleChoiceController.save(callback)
                  : null,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: widget.singleChoiceController.submitButtonOn == true
                  ? () => widget.singleChoiceController.submit(callback)
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
