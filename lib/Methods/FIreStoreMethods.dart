import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addWord({
    required String book,
    required String word,
    required String tag,
    required String uid,
  }) async {
    _firestore
        .collection('User')
        .doc(uid)
        .collection('Words')
        .add({'book': book, 'word': word, 'tag': tag});
  }

  Future<void> addBook({
    required String book,
    required String picUrl,
    required String uid,
  }) async {
    _firestore
        .collection('User')
        .doc(uid)
        .collection('Book')
        .add({'name': book, 'picUrl': picUrl});
  }
}
