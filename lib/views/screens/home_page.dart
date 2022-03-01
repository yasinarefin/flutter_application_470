import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/user_controller.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_application_470/services/web_services.dart';
import 'package:flutter_application_470/views/screens/login_page.dart';
import 'package:flutter_application_470/views/widgets/navigation_drawer.dart';
import 'package:flutter_application_470/views/widgets/quiz_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static final routeName = '/home_page';
  final UserModelController uc = Get.find();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quizzes'),
          actions: [
            PopupMenuButton(
              onSelected: handleClick,
              itemBuilder: (context) {
                return {'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Running',
                icon: Icon(Icons.running_with_errors),
              ),
              Tab(
                text: 'Upcoming',
                icon: Icon(Icons.upcoming),
              ),
              Tab(
                text: 'All',
                icon: Icon(Icons.all_out),
              ),
            ],
          ),
        ),
        drawer: NavigationDrawer(),
        body: TabBarView(
          children: [
            Container(
              child: QuizListView(
                quizStatus: 'running',
              ),
            ),
            Container(
              child: QuizListView(
                quizStatus: 'upcoming',
              ),
            ),
            Container(
              child: QuizListView(
                quizStatus: 'all',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(String option) async {
    if (option == 'Logout') {
      await WebServices.logOut(uc.getUser().token);
      Get.offNamed(LoginPage.routeName);
    }
  }
}

class QuizListView extends StatelessWidget {
  final String quizStatus;
  final UserModelController uc = Get.find();
  QuizListView({Key? key, required this.quizStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizModel>>(
      future: WebServices.getQuizzes(uc.getUser().token, quizStatus),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Text('Error loading quizzes1');
          } else if (snapshot.data != null) {
            var qList = snapshot.data as List<QuizModel>;

            return ListView.builder(
              itemCount: qList.length,
              itemBuilder: (context, i) {
                return QuizDetails(
                  quizModel: qList[i],
                );
              },
            );
          } else {
            return const Text('Error loading quizzes');
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
