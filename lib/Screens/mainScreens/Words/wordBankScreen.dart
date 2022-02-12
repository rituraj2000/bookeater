import 'package:bookeater/Models/wb_element.dart';
import 'package:bookeater/Providers/word_bank.dart';
import 'package:bookeater/Widgets/text_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../constants.dart';
import '../../quiz_page.dart';

class WordBankScreen extends StatefulWidget {
  String uid;
  WordBankScreen({required this.uid});
  @override
  _WordBankScreenState createState() => _WordBankScreenState();
}

class _WordBankScreenState extends State<WordBankScreen> {
  final WordBank _wordbank = WordBank();

  //Functions
  Future<void> getWords() async {
    await _wordbank!.populateWordList(widget.uid);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getWords();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //My Words: Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Words',
                  style: typewriterRegular40,
                ),
                Text(
                  'of Today',
                  style: typewriterRegular20,
                ),
              ],
            ),
            //Today's Words: Wrapper
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.all(Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Wrap(
                children: _wordbank!
                    .onlyWords()
                    .map(
                      (word) => GestureDetector(
                        onTap: () {},
                        child: TextBox(text: word),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 50),
            //My Phrases: Text and instructions
            Text(
              'My Phrases',
              style: typewriterRegular40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select a phrase below from your wordbank and chose the correct words for it',
                style: gilroyRegular,
              ),
            ),
            //Phrases: ListTiles
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: _wordbank!.tagList.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        word: WB_element(
                          word: _wordbank!.tagList[index],
                          tag: _wordbank!.tagList[index],
                        ),
                        uid: widget.uid,
                        isTagPassed: false,
                      ),
                    ),
                  );
                },
                child: TextBox(
                  text: _wordbank!.tagList[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
