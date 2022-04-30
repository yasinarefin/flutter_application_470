import 'package:flutter_application_470/controller/screen_controller/signup_page_controller.dart';
import 'package:flutter_application_470/controller/user_controller/user_controller.dart';
import 'package:flutter_application_470/models/api_response_model.dart';
import 'package:flutter_application_470/models/sign_up_form.dart';
import 'package:flutter_application_470/models/user_model.dart';
import 'package:flutter_application_470/utils/web_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserModel testUserModel = UserModel(
    email: 'test@gmail.com',
    username: 'test',
    firstName: 'test',
    lastName: 'test',
    token: '9990e0ee933b5a4d89d78329f54486e6aa0a9affcb34892527ddbc434c160a66',
    joiningDate: 'joiningDate',
  );

  test('Test user controller', () async {
    UserModelController controller = new UserModelController();
    controller.setUserModel(testUserModel);

    expect(controller.getUser().email, 'test@gmail.com');
  });
}
