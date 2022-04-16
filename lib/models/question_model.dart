/*
This model holds the information for a single quiz question.
*/
class QuestionModel {
  final String quizID;
  final int questionNo;
  final String
      type; // there can be three type of quetions. sc =single choice, mc = multiple choice, inp = value input
  final int score;
  final String question;
  final List<dynamic> options;

  QuestionModel(
      {required this.quizID,
      required this.questionNo,
      required this.type,
      required this.score,
      required this.question,
      required this.options});
}
