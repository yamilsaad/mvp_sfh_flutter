import 'package:flutter/material.dart';

class TextSubtitleWidget extends StatelessWidget {
  final String titleText;
  final TextStyle styleText =
      TextStyle(color: Colors.pink, fontSize: 20, fontWeight: FontWeight.bold);

  TextSubtitleWidget({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Text(
          titleText,
          style: styleText,
        )),
      ),
    );
  }
}
