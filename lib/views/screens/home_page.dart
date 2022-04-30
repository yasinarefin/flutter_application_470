import 'package:flutter/material.dart';
import 'package:flutter_application_470/controller/screen_controller/home_page_controller.dart';
import 'package:flutter_application_470/controller/user_controller/user_controller.dart';
import 'package:flutter_application_470/views/widgets/navigation_drawer.dart';
import 'package:flutter_application_470/views/widgets/quiz_widget.dart';
import 'package:get/get.dart';

/*
  find the associated controller in screen_controller/home_page_controller
*/

class HomePage extends StatelessWidget {
  static final routeName = '/home_page';
  final UserModelController uc = Get.find(); // get current logged in user
  final HomePageController homePageController = HomePageController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quizzes'),
          actions: [
            PopupMenuButton(
              onSelected: homePageController.handleClick,
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
                homePageController: homePageController,
              ),
            ),
            Container(
              child: QuizListView(
                quizStatus: 'upcoming',
                homePageController: homePageController,
              ),
            ),
            Container(
              child: QuizListView(
                quizStatus: 'all',
                homePageController: homePageController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizListView extends StatelessWidget {
  final String quizStatus; // determines the tab: running, upcoming, or ended
  final UserModelController uc = Get.find();
  final HomePageController homePageController;
  QuizListView(
      {Key? key, required this.quizStatus, required this.homePageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: homePageController.getQuizzes(uc.getUser().token, quizStatus),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Text('Error loading quizzes1');
          } else if (snapshot.data != null) {
            var qListSize = snapshot.data as int;

            return ListView.builder(
              itemCount: qListSize,
              itemBuilder: (context, i) {
                return QuizDetails(
                  quizModel: homePageController.getQuizModel(i),
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
