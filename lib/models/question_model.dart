class QuestionModel {
  final String quizID;
  final int questionNo;
  final String type;
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
