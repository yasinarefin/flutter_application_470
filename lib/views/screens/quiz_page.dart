import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/user_controller/user_controller.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/views/widgets/question_widget.dart';
import 'package:flutter_application_470/controller/screen_controller/quiz_page_controller.dart';
import 'package:get/get.dart';

/*
All the quetions of the quiz is listed in this page.
User can submit, save a question if quiz is running.


find the associated controller in screen_controller/quiz_page_controller

*/

class QuizPage extends StatelessWidget {
  static const routeName = '/quiz_page';
  final UserModelController uc = Get.find();
  final QuizModel quizModel = Get.arguments as QuizModel;

  @override
  Widget build(BuildContext context) {
    QuizPageController quizPageController =
        QuizPageController(quizModel: quizModel);

    Get.put(quizPageController);
    QuizPageController controller = Get.find();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<int>(
            future: controller.getQuestions(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return const Text('Error');
                } else if (snapshot.data != null) {
                  var numberOfQuestions = snapshot.data as int;
                  if (numberOfQuestions == -1) {
                  } else {
                    return LayoutBuilder(builder: (ctx, constraints) {
                      return Column(
                        children: [
                          Container(
                            height: constraints.maxHeight * .03,
                            child: Text('score: ' +
                                controller.getScore() +
                                '/' +
                                quizModel.totalScore.toString()),
                          ),
                          Container(
                            height: constraints.maxHeight * .97,
                            child: ListView.builder(
                              itemCount: numberOfQuestions,
                              itemBuilder: (context, i) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 8,
                                  child: QuizQuestion(
                                    questionNo: i,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    });
                  }
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_application_470/controller/participation_status_controller.dart';
// import 'package:flutter_application_470/controller/user_controller.dart';
// import 'package:flutter_application_470/models/question_model.dart';
// import 'package:flutter_application_470/models/quiz_model.dart';
// import 'package:flutter_application_470/views/widgets/question_widget.dart';
// import 'package:flutter_application_470/controller/screen_controller/quiz_page_controller.dart';
// import 'package:get/get.dart';

// /*
// All the quetions of the quiz is listed in this page.
// User can submit, save a question if quiz is running.
// */

// class QuizPage extends StatelessWidget {
//   static const routeName = '/quiz_page';
//   final UserModelController uc = Get.find();
//   final QuizModel quizModel = Get.arguments as QuizModel;

//   @override
//   Widget build(BuildContext context) {
//     QuizPageController questionListController =
//         QuizPageController(quizModel: quizModel);

//     Get.put(questionListController);
//     QuizPageController qlc = Get.find();

//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder<List<QuestionModel>>(
//             future: qlc.getQuestions(),
//             builder: (ctx, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasError || !snapshot.hasData) {
//                   return const Text('Error');
//                 } else if (snapshot.data != null) {
//                   var list = snapshot.data as List<QuestionModel>;
//                   if (list.length == 0) {
//                     return const Text('Error');
//                   } else {
//                     ParticipationStatusController psc = Get.find();
//                     return LayoutBuilder(builder: (ctx, constraints) {
//                       return Column(
//                         children: [
//                           Container(
//                             height: constraints.maxHeight * .03,
//                             child: Text('score: ' +
//                                 psc.getScore() +
//                                 '/' +
//                                 quizModel.totalScore.toString()),
//                           ),
//                           Container(
//                             height: constraints.maxHeight * .97,
//                             child: ListView.builder(
//                               itemCount: list.length,
//                               itemBuilder: (context, i) {
//                                 return Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                   ),
//                                   elevation: 8,
//                                   child: QuizQuestion(
//                                     question: list[i],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     });
//                   }
//                 }
//               }
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }),
//       ),
//     );
//   }
// }
