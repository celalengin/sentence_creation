import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../items/custom_elevated_button.dart';
import '../constants.dart';
import '../providers/practice_state.dart';
import '../pages/practice_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "Sentence\nCreation",
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            CustomElevatedButton(
                text: "Start",
                buttonColor: Colors.amber,
                textColor: Colors.black,
                onPressed: () {
                  context.read<PracticeState>().resetValues();
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PracticePage()));
                }),
          ],
        ),
      ),
    );
  }
}
