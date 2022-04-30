import 'package:flutter_application_470/controller/screen_controller/signup_page_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/sign_up_form.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String testEmail = "test@gmail.com";
  String testPassword = "testPassword";
  String testUserName = "test";
  String testFirstName = "test";
  String testLastName = "test";

  test('Test user signup', () async {
    ApiResponseModel response = await WebServices.signUp(
      SignUpForm(
        email: testEmail,
        username: testUserName,
        password: testPassword,
        firstName: testFirstName,
        lastName: testLastName,
      ),
    );

    expect(response.statusCode, 201);
  });
}
