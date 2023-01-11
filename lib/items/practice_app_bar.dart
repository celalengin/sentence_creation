import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../providers/practice_state.dart';

AppBar practiceAppBar(BuildContext context) {
  bool scoreAnimation = false;

  return AppBar(
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Consumer<PracticeState>(
      builder: (context, state, widget) {
        if (state.isCorrect == true) {
          scoreAnimation = true;
          Future.delayed(Duration.zero, () {
            scoreAnimation = false;
          });
        }

        return Row(
          children: [
            _closeButton(context),
            Expanded(child: _buildLinearPercentIndicator(state)),
            _scoreWidget(scoreAnimation, state),
          ],
        );
      },
    ),
  );
}

LinearPercentIndicator _buildLinearPercentIndicator(PracticeState state) {
  return LinearPercentIndicator(
    padding: EdgeInsets.zero,
    animateFromLastPercent: true,
    animation: true,
    animationDuration: 300,
    lineHeight: 10,
    percent: state.quesDoneLength / state.allQues.length,
    backgroundColor: Colors.grey[300],
    progressColor: Colors.amber,
    barRadius: const Radius.circular(16),
  );
}

Padding _scoreWidget(bool scoreAnimation, PracticeState state) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: scoreAnimation == true
              ? FadeInUp(
                  from: 40,
                  duration: const Duration(milliseconds: 200),
                  child: _score(state),
                )
              : _score(state),
        ),
      ),
    ),
  );
}

Center _score(PracticeState state) {
  return Center(
    child: Text(
      state.score.toString(),
      style: const TextStyle(
          color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );
}

IconButton _closeButton(BuildContext context) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.close,
        size: 27,
        color: Colors.grey[700],
      ));
}
