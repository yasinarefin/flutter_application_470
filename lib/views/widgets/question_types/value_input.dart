import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_controller/value_input_controller.dart';

class ValueInputQuestion extends StatefulWidget {
  ValueInputController valueInputController;
  ValueInputQuestion({required this.valueInputController});

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
