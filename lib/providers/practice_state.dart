import '../pages/finish_page.dart';
import 'package:flutter/cupertino.dart';

class PracticeState with ChangeNotifier {
  bool _isAnswered = false;

  bool get isAnswered => _isAnswered;

  bool _isCorrect = false;

  bool get isCorrect => _isCorrect;

  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  void next() async {
    _pageIndex++;

    pageController.animateToPage(_pageIndex,
        duration: const Duration(milliseconds: 335), curve: Curves.ease);
    _isAnswered = false;
    _isCorrect = false;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (pageIndex != allQues.length - 1) {
      next();
    } else {
      goFinishPage(context);
    }
  }

  goFinishPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => FinishPage(
                  score: _score,
                )));
  }

  //for LinearPercentIndicator progress when showed bottomSheet
  int quesDoneLength = 0;

  void resetValues() {
    _pageIndex = 0;
    _isCorrect = false;
    _isAnswered = false;
    quesDoneLength = 0;
    allQues = [];
    _score = 0;
  }

  void correct() {
    _isCorrect = true;
    _isAnswered = true;
    quesDoneLength++;
    increaseScore();
    notifyListeners();
  }

  void wrong() {
    _isCorrect = false;
    _isAnswered = true;
    quesDoneLength++;
    notifyListeners();
  }

  List<Widget> allQues = [];

  int _score = 0;

  int get score => _score;

  void increaseScore() {
    _score = _score + 25;
    notifyListeners();
  }
}
