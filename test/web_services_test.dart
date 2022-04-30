import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String testToken =
      "9990e0ee933b5a4d89d78329f54486e6aa0a9affcb34892527ddbc434c160a66";
  String testQuizStatus = "all";
  String testQuizId = "valorant_quiz";
  test('Test quiz list fetch', () async {
    ApiResponseModel response =
        await WebServices.getQuizzes(testToken, testQuizStatus);
    expect(response.statusCode, 200);
  });
  test('Test user fetch', () async {
    ApiResponseModel response = await WebServices.getUser(testToken);
    expect(response.statusCode, 200);
  });
  test('Test question fetch', () async {
    ApiResponseModel response =
        await WebServices.getQuestions(testToken, testQuizId);
    expect(response.statusCode, 200);
  });
}
