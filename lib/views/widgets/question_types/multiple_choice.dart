import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_controller/multiple_choice_controller.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final MultipleChoiceController multipleChoiceController;
  MultipleChoiceQuestion({Key? key, required this.multipleChoiceController})
      : super(key: key);
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
        Text(widget.multipleChoiceController.questionModel.question),
        Column(
          children: [
            for (int i = 0;
                i <
                    widget
                        .multipleChoiceController.questionModel.options.length;
                i++)
              CheckboxListTile(
                title: Text(
                    widget.multipleChoiceController.questionModel.options[i]),
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
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: widget.multipleChoiceController.saveButtonOn == true
                  ? () => widget.multipleChoiceController.save(callback)
                  : null,
              child: const Text('Save'),
            ),
            ElevatedButton(
              onPressed: widget.multipleChoiceController.submitButtonOn == true
                  ? () => widget.multipleChoiceController.submit(callback)
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
