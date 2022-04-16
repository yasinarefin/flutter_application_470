import 'dart:convert';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/participation_model.dart';
import 'package:flutter_application_470/models/question_model.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/models/sign_up_form.dart';
import 'package:flutter_application_470/utils/http_utils.dart';
import 'package:flutter_application_470/utils/storage_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

/*
Here, all the api endpoints are kept.
Note: No api call is performed here. 
Here we store all the api endpoints which can later be called
in the controllers 
*/

class WebServices {
  static Future<ApiResponseModel> login(String email, String password) async {
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
      return ApiResponseModel(statusCode: 200, data: true);
    }
    return ApiResponseModel(statusCode: loginResponse.statusCode, data: false);
  }

  static Future<ApiResponseModel> logOut(String token) async {
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
      return ApiResponseModel(statusCode: 200, data: true);
    }
    return ApiResponseModel(statusCode: response.statusCode, data: false);
  }

  static Future<ApiResponseModel> signUp(SignUpForm s) async {
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
      return ApiResponseModel(statusCode: 201, data: 'ok');
    }

    return ApiResponseModel(
      statusCode: signUpResponse.statusCode,
      data: jsonDecode(signUpResponse.body)['message'],
    );
  }

  static Future<ApiResponseModel> getUser(String token) async {
    var headers = {
      "Authorization": token,
    };
    final response =
        await HTTPUtils.get(path: '/user/get_user/', headers: headers);
    if (response.statusCode == 200) {
      Map<String, String> obj = Map.castFrom(jsonDecode(response.body));
      return ApiResponseModel(
        statusCode: response.statusCode,
        data: obj,
      );
    }
    return ApiResponseModel(statusCode: response.statusCode);
  }

  // returns list of maps of quizzes
  static Future<ApiResponseModel> getQuizzes(
      String token, String status) async {
    var headers = {
      "Authorization": token,
    };
    final response =
        await HTTPUtils.get(path: '/quiz/view/$status/', headers: headers);
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

    return ApiResponseModel(statusCode: response.statusCode, data: obj);
  }

  // get all question list
  static Future<ApiResponseModel> getQuestions(
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

      return ApiResponseModel(statusCode: 200, data: questions);
    }
    return ApiResponseModel(
      statusCode: response.statusCode,
    );
  }

  // submit an answer
  static Future<ApiResponseModel> submitAnswer(
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
      return ApiResponseModel(
        statusCode: submitResponse.statusCode,
      );
    }
    Map<String, dynamic> response = jsonDecode(submitResponse.body);

    return ApiResponseModel(
      statusCode: submitResponse.statusCode,
      data: response['message'],
    );
  }

  static Future<ApiResponseModel> saveAnswer(
    String token,
    String quizID,
    int questionNo,
    List<dynamic> ans,
  ) async {
    print('aaa' + ans.toString());
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
    return ApiResponseModel(statusCode: submitResponse.statusCode);
  }

  // get participation status
  static Future<ApiResponseModel> getParticipationStatus(
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
      return ApiResponseModel(statusCode: 200, data: participationModel);
    }
    return ApiResponseModel(statusCode: response.statusCode);
  }
}
