import 'package:bookeater/Models/wb_element.dart';
import 'package:bookeater/Providers/word_bank.dart';
import 'package:bookeater/Widgets/quiz_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class QuizPage extends StatefulWidget {
  bool isTagPassed;
  WB_element word;
  String uid;
  QuizPage({required this.isTagPassed, required this.word, required this.uid});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List options = [];
  List<WB_element> chosenOptions = [];

  //Functions
  Future<void> getWords() async {
    WordBank wordBank = WordBank();
    //await wordBank.populateWordList();
    options = await wordBank.optionsFromWordList(uid: widget.uid);
    setState(() {});
  }

  void addToChosenOption(WB_element word) {
    chosenOptions.add(word);
  }

  void check() {
    bool check = chosenOptions.every(
      (element) => element.tag == widget.word.tag,
    );
    if (check) {
      print('Gotcha');
    } else {
      print('Try Again');
    }

    options = [];
  }

  @override
  void initState() {
    super.initState();
    getWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0XFF8B80B6),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(FontAwesomeIcons.angleLeft),
        ),
        title: Text('Revision'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Text Word
              Text(
                'Select the words synonymous with',
                style: gilroyMedium20,
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  widget.word.word,
                  style: gilroyBold40.copyWith(color: Colors.orange),
                ),
              ),

              //Options
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return QuizBox(
                        word: options[index],
                        onTap: () {
                          addToChosenOption(options[index]);
                        });
                  }),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Submit Button
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        check();
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 60, 20, 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: blackBorder,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          'SUMBIT',
                          style: gilroyBold30.copyWith(
                              fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  //View Answer Button
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 60, 20, 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: blackBorder,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'View Answer',
                        style: gilroyBold30.copyWith(
                            fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
