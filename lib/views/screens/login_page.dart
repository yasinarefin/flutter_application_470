import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/login_controller.dart';
import 'package:flutter_application_470/views/screens/signup_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  static final routeName = '/login_page';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login page',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InputForm(),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(SignUpPage());
                },
                child: const Text('create new account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final LoginController _loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginController.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _loginController.emailController,
            decoration: const InputDecoration(
              labelText: 'email',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'email cannot be empty';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _loginController.passWordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'password',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.length < 4) {
                return "password must be at least 4 characters";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          LoginButton(loginController: _loginController),
        ],
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  final LoginController loginController;
  const LoginButton({Key? key, required this.loginController})
      : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLogging = false;
  void callbck() {
    setState(() {
      isLogging = !isLogging;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogging == false
        ? ElevatedButton(
            onPressed: () => widget.loginController.loginEvent(callbck),
            child: const Text('Login'),
          )
        : const Text('logging.....');
  }
}
