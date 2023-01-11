import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../items/custom_elevated_button.dart';
import '../../constants.dart';
import '../../providers/practice_state.dart';

class StatusBottomSheetWidget extends StatelessWidget {
  final String sentence;
  final bool isCorrect;

  const StatusBottomSheetWidget(
      {super.key, required this.sentence, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    List<String> sentenceWords = sentence.split("*");

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isCorrect ? Colors.green[100]! : Colors.red[100]!,
            borderRadius: statusBottomSheetRadius),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isCorrect ? "Correct" : "Correct answer:",
                    style: TextStyle(
                      color: isCorrect ? Colors.green[600]! : Colors.red[600]!,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    runAlignment: WrapAlignment.center,
                    children: sentenceWords.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.4, vertical: 4),
                        child: Text(
                          e,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: isCorrect
                                ? Colors.green[600]!
                                : Colors.red[600]!,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomElevatedButton(
                    text: "Continue",
                    buttonColor:
                        isCorrect ? Colors.green[600]! : Colors.red[600]!,
                    textColor: Colors.white,
                    onPressed: () {
                      var state = context.read<PracticeState>();
                      Navigator.pop(context);
                      state.nextPage(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
