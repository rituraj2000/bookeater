import 'package:bookeater/Models/wb_element.dart';
import 'package:bookeater/Providers/word_bank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddWord extends StatefulWidget {
  const AddWord({Key? key}) : super(key: key);

  @override
  _AddWordState createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final _wordController = TextEditingController();
  final _tagController = TextEditingController();

  void addToWordBank() {
    Provider.of<WordBank>(context, listen: false).addToWordBank(
        WB_element(tag: _tagController.text, word: _wordController.text));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            TextField(
              controller: _wordController,
            ),
            TextField(
              controller: _tagController,
            ),
            TextButton(onPressed: addToWordBank, child: Text('Add to WordBank'))
          ],
        ),
      ),
    );
  }
}
