/*
This model holds the participation status for a particular quiz.
*/

class ParticipationModel {
  final String quizId;
  final String userEmail;
  final List<dynamic>
      submittedAnswers; // size of the list = number of questions
  final List<dynamic>
      savedAnswers; // Ex, savedAnswers[0] holds the saved answers for question no 1
  final int score;
  ParticipationModel(
      {required this.quizId,
      required this.userEmail,
      required this.submittedAnswers,
      required this.savedAnswers,
      required this.score});
}
