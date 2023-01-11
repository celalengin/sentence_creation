import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomElevatedButton(
      {required this.text,
      required this.buttonColor,
      required this.textColor,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              surfaceTintColor: buttonColor,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              backgroundColor: buttonColor,
              elevation: 7),
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 21, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
