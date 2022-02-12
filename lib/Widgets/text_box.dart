import 'package:flutter/material.dart';

import '../constants.dart';

class TextBox extends StatelessWidget {
  TextBox({required this.text});
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
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
      child: Text(
        text,
        style: gilroyMedium20,
      ),
    );
  }
}
