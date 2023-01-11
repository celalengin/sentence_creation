import '../items/status_bottom_sheet_widget.dart';

import 'package:flutter/material.dart';

void statusBottomSheet({
  required BuildContext context,
  required bool isCorrect,
  required String sentence,
  bool isSentenceCreation = false,
}) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      elevation: 0,
      barrierColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return StatusBottomSheetWidget(
          sentence: sentence,
          isCorrect: isCorrect,
        );
      });
}

const BorderRadiusGeometry statusBottomSheetRadius =
    BorderRadius.vertical(top: Radius.circular(12));
