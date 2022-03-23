class ParticipationModel {
  final String quizId;
  final String userEmail;
  final List<dynamic> submittedAnswers;
  final List<dynamic> savedAnswers;
  final int score;
  ParticipationModel(
      {required this.quizId,
      required this.userEmail,
      required this.submittedAnswers,
      required this.savedAnswers,
      required this.score});
}
