import 'package:flutter/material.dart';
import '../constants.dart';
import '../items/status_bottom_sheet_widget.dart';

void statusBottomSheet({
  required BuildContext context,
  required bool isCorrect,
  required String sentence,
}) {
  showModalBottomSheet(
      shape:
          const RoundedRectangleBorder(borderRadius: statusBottomSheetRadius),
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
