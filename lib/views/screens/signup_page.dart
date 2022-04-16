import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/screen_controller/signup_page_controller.dart';

/*
  find the associated controller in screen_controller/signup_page_controller
*/

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const Text(
                  'Signup page',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SignUpFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpFormWidget extends StatefulWidget {
  @override
  State<SignUpFormWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpFormWidget> {
  SignUpController _signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpController.signUpFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _signUpController.emailController,
            decoration: const InputDecoration(
              labelText: 'email',
              border: OutlineInputBorder(),
            ),
            validator: _signUpController.validateEmail,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _signUpController.userNameController,
            decoration: const InputDecoration(
              labelText: 'username',
              border: OutlineInputBorder(),
            ),
            validator: _signUpController.validateUserName,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _signUpController.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'password',
              border: OutlineInputBorder(),
            ),
            validator: _signUpController.validatePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _signUpController.firstNameController,
            decoration: const InputDecoration(
              labelText: 'first name',
              border: OutlineInputBorder(),
            ),
            validator: _signUpController.validateFirstName,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _signUpController.lastNameController,
            decoration: const InputDecoration(
              labelText: 'last name',
              border: OutlineInputBorder(),
            ),
            validator: _signUpController.validateLastName,
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpButton(signUpController: _signUpController),
        ],
      ),
    );
  }
}

class SignUpButton extends StatefulWidget {
  final SignUpController signUpController;
  const SignUpButton({Key? key, required this.signUpController})
      : super(key: key);

  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool isSigning = false;
  void callback() => setState(() {
        isSigning = !isSigning;
      });
  @override
  Widget build(BuildContext context) {
    return !isSigning
        ? ElevatedButton(
            onPressed: () => widget.signUpController.signUpEvent(callback),
            child: const Text('Sign up'),
          )
        : const Text('Signing up');
  }
}
