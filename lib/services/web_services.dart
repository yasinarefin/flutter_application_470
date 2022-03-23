import 'dart:convert';
import 'package:flutter_application_470/models/participation_model.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/models/sign_up_form.dart';
import 'package:flutter_application_470/http_utils.dart';
import 'package:flutter_application_470/services/storage_services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_application_470/services/user_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebServices {
  static Future<bool> login(String email, String password) async {
    final loginResponse = await HTTPUtils.post(
      path: '/auth/login/',
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
      headers: {},
    );

    if (loginResponse.statusCode == 200) {
      String token = jsonDecode(loginResponse.body)['token'];
      // save token to android keystore if not running on web
      if (!kIsWeb) {
        await StorageServices.setToken(token: token);
      } else {
        // for web do this
        //await UserIntialize.initUserWeb(token);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }
      return true;
    }
    return false;
  }

  static Future<bool> logOut(String token) async {
    final prefs = await SharedPreferences.getInstance();
    kIsWeb
        ? await prefs.remove('token')
        : await StorageServices.deleteToken(); // delete from device first
    final response = await HTTPUtils.post(
      path: '/auth/logout/',
      body: jsonEncode(
        <String, String>{
          'token': token,
        },
      ),
      headers: {},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<String> signUp(SignUpForm s) async {
    final signUpResponse = await HTTPUtils.post(
      path: '/user/create_user/',
      body: jsonEncode(<String, String>{
        'email': s.email,
        'user_name': s.username,
        'password': s.password,
        'first_name': s.firstName,
        'last_name': s.lastName,
      }),
      headers: {},
    );
    if (signUpResponse.statusCode == 201) {
      return 'ok';
    }
    return jsonDecode(signUpResponse.body)['message'];
  }

  static Future<Map<String, String>> getUser(String token) async {
    var headers = {
      "Authorization": token,
    };
    final response =
        await HTTPUtils.get(path: '/user/get_user/', headers: headers);
    if (response.statusCode == 200) {
      Map<String, String> obj = Map.castFrom(jsonDecode(response.body));
      return obj;
    }
    return {"error": "401"};
  }

  // returns list of maps of quizzes
  static Future<List<QuizModel>> getQuizzes(String token, String status) async {
    var headers = {
      "Authorization": token,
    };
    final response =
        await HTTPUtils.get(path: '/quiz/view/$status/', headers: headers);
    if (response.statusCode == 200) {
      List<QuizModel> obj = (jsonDecode(response.body) as List).map((e) {
        return QuizModel(
          quizId: e['quiz_id'],
          quizName: e['name'],
          totalScore: e['total_score'],
          quizDescription: e['description'],
          startDate: DateTime.parse(e['start_time']),
          endDate: DateTime.parse(e['end_time']),
          status: e['status'],
        );
      }).toList();
      return obj;
    }
    return [];
  }

  // get all question list
  static Future<List<QuestionModel>> getQuestions(
      String token, String quizID) async {
    var headers = {
      "Authorization": token,
      "QuizID": quizID,
    };
    final response =
        await HTTPUtils.get(path: '/quiz/questions/', headers: headers);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);
      List<dynamic> obj = decodedResponse['questions'];
      List<QuestionModel> questions = [];
      for (int i = 0; i < obj.length; i++) {
        questions.add(QuestionModel(
          quizID: quizID,
          questionNo: i,
          type: obj[i]['type'],
          score: obj[i]['score'],
          question: obj[i]['question'],
          options: obj[i]['options'],
        ));
      }

      return questions;
    }
    return [];
  }

  // submit an answer
  static Future<String> submitAnswer(
    String token,
    String quizID,
    int questionNo,
    List<dynamic> ans,
  ) async {
    print(ans);
    final submitResponse = await HTTPUtils.post(
      path: '/quiz/submit_ans/',
      body: jsonEncode(<String, dynamic>{
        'quiz_id': quizID,
        'question_no': questionNo,
        'answer': ans,
      }),
      headers: {
        'Authorization': token,
      },
    );
    if (submitResponse.statusCode == 500) {
      return "error";
    }
    if (submitResponse.statusCode == 200) {
      return 'ok';
    }
    Map<String, dynamic> response = jsonDecode(submitResponse.body);
    if (response.containsKey('message')) return response['message'];
    return 'error';
  }

  static Future<String> savedAnswer(
    String token,
    String quizID,
    int questionNo,
    List<dynamic> ans,
  ) async {
    final submitResponse = await HTTPUtils.post(
      path: '/quiz/save_ans/',
      body: jsonEncode(<String, dynamic>{
        'quiz_id': quizID,
        'question_no': questionNo,
        'answer': ans,
      }),
      headers: {
        'Authorization': token,
      },
    );
    if (submitResponse.statusCode == 500) {
      return "error";
    }
    if (submitResponse.statusCode == 200) {
      return 'ok';
    }
    Map<String, dynamic> response = jsonDecode(submitResponse.body);
    if (response.containsKey('message')) return response['message'];
    return 'error';
  }

  // get participation status
  static Future<Map<String, dynamic>> getParticipationStatus(
      String token, String quizID) async {
    var headers = {
      "Authorization": token,
      "QuizID": quizID,
    };
    final response = await HTTPUtils.get(
        path: '/quiz/participation_status/', headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> obj = Map.castFrom(jsonDecode(response.body));
      ParticipationModel participationModel = ParticipationModel(
        quizId: obj['quiz'],
        userEmail: obj['user'],
        submittedAnswers: obj['answers'],
        savedAnswers: obj['saved_answers'],
        score: obj['score'],
      );
      return {'result': participationModel};
    }
    return {'error': 'no participation found'};
  }
}
