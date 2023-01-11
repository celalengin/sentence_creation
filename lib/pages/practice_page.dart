import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../items/sentence_creation_widget.dart';
import '../items/practice_app_bar.dart';
import '../providers/practice_state.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> sentences = [...sentencesData]..shuffle();

    context.read<PracticeState>().allQues =
        sentences.take(4).map((e) => SentenceCreation(sentence: e)).toList();

    return Scaffold(
      appBar: practiceAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Consumer<PracticeState>(builder: (context, state, widget) {
              return PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: state.pageController,
                itemBuilder: (context, index) => state.allQues[index],
                itemCount: state.allQues.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}
