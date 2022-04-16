/*
This model holds the information for a single quiz. 
*/

class QuizModel {
  final String quizId; // each quiz has unique id
  final String quizName;
  final int totalScore;
  final String quizDescription;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // determines if the quiz is upcoming, running or ended.

  QuizModel(
      {required this.quizId,
      required this.quizName,
      required this.totalScore,
      required this.quizDescription,
      required this.startDate,
      required this.endDate,
      required this.status});

  String getStatus() {
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate)) {
      return 'running';
    } else if (DateTime.now().isBefore(startDate)) {
      return 'upcoming';
    }
    return 'ended';
  }
}
