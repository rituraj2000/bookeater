import 'package:cloud_firestore/cloud_firestore.dart';

class WB_element {
  WB_element({required this.tag, required this.word});

  String tag;
  String word;

  static WB_element fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return WB_element(
      word: snapshot["word"],
      tag: snapshot["tag"],
    );
  }
}
