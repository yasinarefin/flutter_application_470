import 'package:flutter_application_470/controller/screen_controller/signup_page_controller.dart';
import 'package:flutter_application_470/utils/storage_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String testEmail = "yasin@gmail.com";
  String testUserName = "yasin";
  test('Test email validator', () async {
    SignUpController controller = new SignUpController();

    expect(null, controller.validateEmail(testEmail));
  });

  test('Test username validator', () async {
    SignUpController controller = new SignUpController();

    expect(null, controller.validateUserName(testUserName));
  });
}
