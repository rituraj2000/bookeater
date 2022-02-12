import 'package:bookeater/Methods/FIreStoreMethods.dart';
import 'package:bookeater/Providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class MyBottomSheet extends StatefulWidget {
  MyBottomSheet({required this.currentBook});
  String currentBook;

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final TextEditingController _wordControler = TextEditingController();
  final TextEditingController _tagControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      color: const Color(0xff757575),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: blackBorder,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          children: <Widget>[
            //TextFields
            TextField(
              controller: _wordControler,
            ),
            TextField(
              controller: _tagControler,
            ),

            //Add Button
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: const Border(
                  left: BorderSide(),
                  top: BorderSide(),
                  bottom: BorderSide(),
                  right: BorderSide(),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.blueAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.3),
                    blurRadius: 3,
                    offset: const Offset(4, 5),
                  ),
                ],
              ),
              width: 250,
              height: 50,
              child: FlatButton(
                onPressed: () async {
                  await FireStoreMethods().addWord(
                    book: widget.currentBook,
                    word: _wordControler.text,
                    tag: _tagControler.text,
                    uid: userProvider.getUser.uid,
                  );
                },
                child: const Text('Add Word'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
