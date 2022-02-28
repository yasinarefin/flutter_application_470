import 'package:flutter/material.dart';
import 'package:flutter_application_470/views/screens/quiz_page.dart';
import 'package:get/get.dart';
import 'package:flutter_application_470/models/quiz_model.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class QuizDetails extends StatelessWidget {
  final QuizModel quizModel;
  const QuizDetails({Key? key, required this.quizModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(QuizPage.routeName, arguments: quizModel);
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Timer(quizModel: quizModel),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      quizModel.quizName,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Total score: ' + quizModel.totalScore.toString(),
                    ),
                  ),
                ],
              ),
              Text(quizModel.quizDescription),
            ],
          ),
        ),
      ),
    );
  }
}

class Timer extends StatefulWidget {
  final QuizModel quizModel;
  const Timer({
    Key? key,
    required this.quizModel,
  }) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    if (widget.quizModel.getStatus() == 'ended') {
      return const Text('finished');
    }

    CountdownTimerController controller = CountdownTimerController(
        onEnd: () async {
          await Future.delayed(const Duration(milliseconds: 50));
          setState(() {});
        },
        endTime: DateTime.now().millisecondsSinceEpoch +
            widget.quizModel.startDate
                .difference(DateTime.now())
                .inMilliseconds);

    if (widget.quizModel.getStatus() == 'running') {
      controller.endTime = DateTime.now().millisecondsSinceEpoch +
          widget.quizModel.endDate.difference(DateTime.now()).inMilliseconds;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.quizModel.getStatus() == 'running') const Text('Running '),
        if (widget.quizModel.getStatus() == 'upcoming')
          const Text('Before start '),
        CountdownTimer(
          endWidget: const Text('...'),
          controller: controller,
        )
      ],
    );
  }
}
