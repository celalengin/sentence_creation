import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../items/custom_elevated_button.dart';
import '../pages/practice_page.dart';

import '../providers/practice_state.dart';

class FinishPage extends StatelessWidget {
  final int score;

  const FinishPage({required this.score, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      score.toString(),
                      style: const TextStyle(
                          fontSize: 70, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Score",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButton(
                text: "Again",
                buttonColor: Colors.amber,
                textColor: Colors.black,
                onPressed: () {
                  context.read<PracticeState>().resetValues();
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PracticePage()));
                }),
            const SizedBox(height: 16),
            CustomElevatedButton(
                text: "Back to Home Page",
                buttonColor: Colors.grey[300]!,
                textColor: Colors.grey[800]!,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
