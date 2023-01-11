import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import '../items/custom_elevated_button.dart';
import '../../constants.dart';
import '../../providers/practice_state.dart';
import '../items/status_bottom_sheet_func.dart';

class SentenceCreation extends StatefulWidget {
  final String sentence;

  const SentenceCreation({super.key, required this.sentence});

  @override
  State<SentenceCreation> createState() => _SentenceCreationState();
}

class _SentenceCreationState extends State<SentenceCreation> {
  List<String> correctWords = [];

  List<String> shuffleWords = [];

  List<String> answerWords = [];

  List<Widget> shuffleWidgetList = [];
  List<Widget> answerWidgetList = [];

  List<String> withoutDottedMark = [];

  generateShuffleWidgets() {
    for (int i = 0; i < shuffleWords.length; i++) {
      shuffleWidgetList.add(shuffleWordWidget(shuffleWords[i], false, i));
    }
  }

  List<String> splitDotted(String dotted) {
    String t = widget.sentence.replaceAll(RegExp('\\$dotted'), ' $dotted');

    return t.split(" ");
  }

  dottedMarkFunc(String dotted) {
    correctWords = splitDotted(dotted);
    withoutDottedMark = [...correctWords]..remove(dotted);

    shuffleWords = [...correctWords]..shuffle();
  }

  @override
  void initState() {
    super.initState();

    if (["?", ",", ".", "!"].any((e) => widget.sentence.contains(e))) {
      //will work for single mark
      if (widget.sentence.contains("?")) {
        dottedMarkFunc("?");
      } else if (widget.sentence.contains(",")) {
        dottedMarkFunc(",");
      } else if (widget.sentence.contains(".")) {
        dottedMarkFunc(".");
      } else {
        dottedMarkFunc("!");
      }
    } else {
      correctWords = widget.sentence.split(" ");
      shuffleWords = [...correctWords]..shuffle();
    }

    generateShuffleWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    //background lines
                    IgnorePointer(
                      child: Column(
                        children: [
                          singleLine(),
                          singleLine(),
                          singleLine(),
                        ],
                      ),
                    ),
                    Wrap(
                      children: answerWidgetList,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: shuffleWidgetList,
                ),
              ),
              checkButton(context),
            ],
          ),
        ],
      ),
    );
  }

  CustomElevatedButton checkButton(BuildContext context) {
    return CustomElevatedButton(
      text: answerWords.isNotEmpty ? "Check" : "Skip",
      buttonColor: answerWords.isNotEmpty ? Colors.amber : Colors.grey[300]!,
      textColor: answerWords.isNotEmpty ? Colors.black : Colors.grey[800]!,
      onPressed: () {
        var state = context.read<PracticeState>();
        if (answerWords.isNotEmpty) {
          if (const IterableEquality().equals(correctWords, answerWords) ||
              (withoutDottedMark.isNotEmpty &&
                  const IterableEquality()
                      .equals(withoutDottedMark, answerWords))) {
            state.correct();
          } else {
            state.wrong();
          }

          statusBottomSheet(
              context: context,
              isCorrect: state.isCorrect,
              sentence: widget.sentence);
        } else {
          state.quesDoneLength++;
          state.nextPage(context);
        }
      },
    );
  }

  Column singleLine() => Column(children: [
        buildSimpleAnswer(),
        buildDivider(),
      ]);

  //get answerWordWidget height for lines
  Opacity buildSimpleAnswer() =>
      Opacity(opacity: 0, child: answerWordWidget("", 0));

  Divider buildDivider() => Divider(
        color: Colors.grey[400],
        height: 0,
      );

  final double _fontSize = 18;

  final EdgeInsetsGeometry _paddingText = const EdgeInsets.fromLTRB(9, 7, 9, 7);

  final EdgeInsetsGeometry _paddingTextContainer = const EdgeInsets.all(4);

  final Color _wordContainerColor = Colors.blue[200]!;

  Widget shuffleWordWidget(String word, bool clicked, int shuffleWidgetIndex) {
    return Padding(
      padding: _paddingTextContainer,
      child: InkWell(
          child: Container(
            decoration: BoxDecoration(
                color: clicked ? Colors.grey[300] : _wordContainerColor,
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: _paddingText,
              child: Text(
                word,
                style: TextStyle(
                  color: clicked ? Colors.transparent : Colors.black,
                  fontSize: _fontSize,
                ),
              ),
            ),
          ),
          onTap: () => shuffleWordPress(clicked, word, shuffleWidgetIndex)),
    );
  }

  shuffleWordPress(bool clicked, String word, int shuffleWidgetIndex) {
    var state = context.read<PracticeState>();
    if (clicked == false && state.isAnswered == false) {
      setState(() {
        shuffleWidgetList[shuffleWidgetIndex] =
            shuffleWordWidget(word, true, shuffleWidgetIndex);

        answerWidgetList.add(answerWordWidget(word, shuffleWidgetIndex));
        answerWords.add(word);
      });
    }
  }

  Widget answerWordWidget(String word, int shuffleWidgetIndex) {
    return Padding(
      padding: _paddingTextContainer,
      child: InkWell(
        child: Consumer<PracticeState>(
          builder: (context, state, widget) {
            Color getColor() {
              if (state.isCorrect == true) {
                return Colors.green;
              } else if (state.isAnswered == true) {
                if (answerWords.indexOf(word) == correctWords.indexOf(word)) {
                  return Colors.green;
                } else {
                  return Colors.red;
                }
              }
              return _wordContainerColor;
            }

            Color getTextColor() {
              if (state.isAnswered == true) {
                return Colors.white;
              }
              return Colors.black;
            }

            return Container(
              decoration: BoxDecoration(
                color: getColor(),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: _paddingText,
                child: Text(
                  word,
                  style: TextStyle(fontSize: _fontSize, color: getTextColor()),
                ),
              ),
            );
          },
        ),
        onTap: () => answerWordPress(word, shuffleWidgetIndex),
      ),
    );
  }

  answerWordPress(String word, int shuffleWidgetIndex) {
    var state = context.read<PracticeState>();
    if (state.isAnswered == false) {
      setState(() {
        shuffleWidgetList[shuffleWidgetIndex] =
            shuffleWordWidget(word, false, shuffleWidgetIndex);
        int y = answerWords.indexOf(word);
        answerWidgetList.removeAt(y);
        answerWords.remove(word);
      });
    }
  }
}
