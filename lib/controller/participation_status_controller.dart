import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:get/get.dart';

// this controller loads  participation status and saves it
class ParticipationStatusController extends GetxController {
  Map<String, dynamic> participationStatus = {};
  List<dynamic> selectedAnswers = [];
  final UserModelController uc = Get.find();
  Future<void> loadData(String quizId) async {
    participationStatus =
        await WebServices.getParticipationStatus(uc.getUser().token, quizId);

    if (!participationStatus.containsKey('error')) {
      selectedAnswers = participationStatus['answers'];
    }
  }
}
