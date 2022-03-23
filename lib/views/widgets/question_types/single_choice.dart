import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_list_controller.dart';
import 'package:flutter_application_470/controller/question_types/single_choice_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:get/get.dart';

// class SingleChoiceQuestion extends StatelessWidget {
//   final QuestionModel questionModel;
//   late SingleChoiceController singleChoiceController;
//   final QuestionListController questionListController = Get.find();

//   SingleChoiceQuestion({Key? key, required this.questionModel})
//       : super(key: key) {
//     singleChoiceController =
//         questionListController.cons[questionModel.questionNo];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: [
//           Text(questionModel.question),
//           SingleChoiceOptions(
//             singleChoiceController: singleChoiceController,
//           ),
//           ElevatedButton(
//             onPressed: singleChoiceController.submitButtonOn.value == true
//                 ? () => singleChoiceController.submit()
//                 : null,
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SingleChoiceOptions extends StatelessWidget {
//   final SingleChoiceController singleChoiceController;
//   const SingleChoiceOptions({Key? key, required this.singleChoiceController})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         children: [
//           for (int i = 0;
//               i < singleChoiceController.questionModel.options.length;
//               i++)
//             ListTile(
//               title: Text(singleChoiceController.questionModel.options[i]),
//               leading: Radio(
//                 value: i,
//                 groupValue: singleChoiceController.selectedIndex,
//                 onChanged: (value) {
//                   singleChoiceController.selectedIndex = value as RxInt;
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

class SingleChoiceQuestion extends StatefulWidget {
  final QuestionModel questionModel;
  late SingleChoiceController singleChoiceController;
  final QuestionListController questionListController = Get.find();
  SingleChoiceQuestion({Key? key, required this.questionModel})
      : super(key: key) {
    singleChoiceController =
        questionListController.cons[questionModel.questionNo];
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
