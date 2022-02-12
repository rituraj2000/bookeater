import 'package:flutter/material.dart';

class BookImageWiget extends StatelessWidget {
  final snap;
  BookImageWiget({required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: 180,
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(),
          top: BorderSide(),
          bottom: BorderSide(),
          right: BorderSide(),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            snap['picUrl'],
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.08),
            blurRadius: 2,
            offset: const Offset(4, 10),
          ),
        ],
      ),
    );
  }
}
