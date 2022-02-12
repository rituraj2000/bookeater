import 'dart:math';
import 'package:bookeater/Models/wb_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class WordBank {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //WordList is operated upon here
  List<WB_element> _wordList = [];

  List<WB_element> get wordList {
    return [..._wordList];
  }

  //Populate the WordBank
  Future<void> populateWordList(String uid) async {
    _wordList = [];

    QuerySnapshot<Map<String, dynamic>> words = await firebaseFirestore
        .collection('User')
        .doc(uid)
        .collection('Words')
        .get();

    for (int i = 0; i <= words.docs.length - 1; i++) {
      Map<String, dynamic> snap = words.docs[i].data();
      WB_element word = WB_element(tag: snap['tag'], word: snap['word']);
      addToWordBank(word);
    }

    wordList.forEach((element) {
      print(element.word);
    });
  }

  //Only get a List of words from wordbank
  List<String> onlyWords() {
    return _wordList.map((e) => e.word).toList();
  }

  //Add a new word to wordbank
  void addToWordBank(WB_element wb_element) {
    _wordList.add(wb_element);
    _addTagToTaglist(wb_element);
    print('WordList length: ${_wordList.length}');
    //notifyListeners();
  }

  //Generate 4 options from WordList
  Future<List<WB_element>> optionsFromWordList({required String uid}) async {
    await populateWordList(uid);
    int i = 1;
    List<WB_element> _options = [];
    print(_wordList.length);
    while (i < 4) {
      int rand = new Random().nextInt(_wordList.length - 1);
      if (!_options.contains(_wordList[rand].word)) {
        _options.add(
            WB_element(tag: _wordList[rand].tag, word: _wordList[rand].word));
        i++;
      }
    }
    _options.add(WB_element(tag: 'None of These', word: 'None Of These'));
    return _options;
  }

  //Tags are operated upon here
  List<String> _tagList = [];

  List<String> get tagList {
    wordList.forEach((wb_element) {
      if (!_tagList.contains(wb_element.tag)) {
        _tagList.add(wb_element.tag);
      }
    });
    return [..._tagList];
  }

  void _addTagToTaglist(WB_element wb_element) {
    if (!tagList.contains(wb_element.tag)) {
      _tagList.add(wb_element.tag);
      //notifyListeners();
    }
  }

  List<String> getWordFromTag(String tag) {
    List<String> _words = [];
    wordList.forEach((wb_element) {
      if (wb_element.tag == tag) {
        _words.add(wb_element.word);
      }
    });

    return _words;
  }
}
