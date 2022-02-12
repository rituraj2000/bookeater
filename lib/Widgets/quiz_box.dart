import 'package:bookeater/Models/wb_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class QuizBox extends StatefulWidget {
  QuizBox({required this.word, required this.onTap});
  WB_element word;
  final VoidCallback onTap;

  @override
  State<QuizBox> createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  bool isSelected = false;

  void toggle() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggle();
        widget.onTap;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
          border: Border.all(color: Colors.indigoAccent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.word.word,
              style: gilroyMedium20,
            ),
            Icon(
              isSelected
                  ? FontAwesomeIcons.solidCircle
                  : FontAwesomeIcons.circle,
              size: 15,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
