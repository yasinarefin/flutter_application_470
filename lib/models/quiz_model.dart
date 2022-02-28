class QuizModel {
  final String quizId;
  final String quizName;
  final int totalScore;
  final String quizDescription;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  QuizModel(
      {required this.quizId,
      required this.quizName,
      required this.totalScore,
      required this.quizDescription,
      required this.startDate,
      required this.endDate,
      required this.status});

  String getStatus() {
    if (DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate))
      return 'running';
    else if (DateTime.now().isBefore(startDate)) return 'upcoming';
    return 'ended';
  }
}
