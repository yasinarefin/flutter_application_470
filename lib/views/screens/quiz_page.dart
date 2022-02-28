import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/question_list_controller.dart';
import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/views/widgets/question_widget.dart';

import 'package:get/get.dart';

class QuizPage extends StatelessWidget {
  static final routeName = '/quiz_page';
  final UserModelController uc = Get.find();
  final QuizModel quizModel = Get.arguments as QuizModel;

  @override
  Widget build(BuildContext context) {
    QuestionListController questionListController =
        QuestionListController(quizModel: quizModel);

    return Scaffold(
      body: FutureBuilder<List<QuestionModel>>(
          future: questionListController.getQuestions(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError || !snapshot.hasData) {
                return const Text('Error');
              } else if (snapshot.data != null) {
                var list = snapshot.data as List<QuestionModel>;
                if (list.length == 0) {
                  return const Text('Error');
                } else {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 8,
                        child: QuizQuestion(
                          question: list[i],
                        ),
                      );
                    },
                  );
                }
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
