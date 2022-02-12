import 'package:bookeater/Methods/FIreStoreMethods.dart';
import 'package:bookeater/Methods/getBookDetails.dart';
import 'package:bookeater/Models/wb_element.dart';
import 'package:bookeater/Providers/userProvider.dart';
import 'package:bookeater/Screens/mainScreens/Profile/profile.dart';
import 'package:bookeater/Widgets/text_box.dart';
import 'package:bookeater/Widgets/wookImageWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../../constants.dart';
import '../../quiz_page.dart';
import 'displayBottomSection.dart';

class DemoHome extends StatefulWidget {
  const DemoHome({Key? key}) : super(key: key);

  @override
  _DemoHomeState createState() => _DemoHomeState();
}

class _DemoHomeState extends State<DemoHome> {
  //Variables
  int _currentbookIndex = 0;
  String currentBook = 'HP';
  String isbn = '';

  //Functions
  //Scan Barcode
  Future<void> scanBarcode() async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
          '#010001', 'Cancel', true, ScanMode.BARCODE);
      if (!mounted) return;
      setState(() {
        isbn = barcode;
      });
    } on PlatformException {
      isbn = 'Error! No Valid Barcode Found';
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //UserName Flashcard
            ShadowContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi!',
                        style: const TextStyle(
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${userProvider.getUser.name}',
                        style: const TextStyle(
                          fontFamily: 'Gilroy-Bold',
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: blackBorder,
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://mir-s3-cdn-cf.behance.net/project_modules/fs/06b4a293391549.5e636b2127277.jpg'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            //Book Image
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .doc(userProvider.getUser.uid)
                  .collection('Book')
                  .snapshots(),
              builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) =>
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (_currentbookIndex > 0) {
                          _currentbookIndex--;
                          print(_currentbookIndex);
                        }

                        currentBook = (snapshot.data!.docs[_currentbookIndex]
                            as dynamic)['name'];
                      });
                      print(currentBook);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                          top: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                          bottom: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                          right: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                        ),
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(10)),
                        color: Colors.yellow,
                      ),
                      child: Icon(FontAwesomeIcons.caretLeft),
                    ),
                  ),
                  BookImageWiget(snap: snapshot.data!.docs[_currentbookIndex]),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (_currentbookIndex < 3) {
                          _currentbookIndex++;
                          print(_currentbookIndex);
                        }
                        currentBook = (snapshot.data!.docs[_currentbookIndex]
                            as dynamic)['name'];
                      });
                      print(currentBook);
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                          top: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                          bottom: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                          right: BorderSide(
                              width: 3, color: Colors.yellow.shade600),
                        ),
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(10)),
                        color: Colors.yellow,
                      ),
                      child: Icon(FontAwesomeIcons.caretRight),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            //AddWord
            Container(
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
                onPressed: () {
                  // await FireStoreMethods().addWord(
                  //     book: currentBook,
                  //     word: 'word3',
                  //     tag: 'tag3',
                  //     uid: '4t9V4mn1j4T1VosFWB0e');

                  showModalBottomSheet(
                      context: context,
                      builder: (context) => MyBottomSheet(
                            currentBook: currentBook,
                          ));
                },
                child: const Text('Add Word'),
              ),
            ),
            const SizedBox(height: 50),

            //Tags
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('User')
                    .doc(userProvider.getUser.uid)
                    .collection('Words')
                    .where('book', isEqualTo: currentBook)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot snap =
                                (snapshot.data! as dynamic).docs[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuizPage(
                                        word: WB_element(
                                          word:
                                              '${(snap.data()! as dynamic)['word']}',
                                          tag:
                                              '${(snap.data()! as dynamic)['tag']}',
                                        ),
                                        uid: userProvider.getUser.uid,
                                        isTagPassed: false,
                                      ),
                                    ),
                                  );
                                },
                                child: TextBox(
                                    text:
                                        '${(snap.data()! as dynamic)['word']}'),
                              ),
                            );
                          })
                      : Text('None');
                })
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          border: blackBorder,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            await scanBarcode();
            print(isbn);
            final title = await getBookTItle(isbn);
            setState(() {
              currentBook = title;
            });
            await FireStoreMethods().addBook(
              book: currentBook,
              picUrl: getBookCover(isbn: isbn),
              uid: userProvider.getUser.uid,
            );
          },
          child: const Icon(FontAwesomeIcons.plus),
        ),
      ),
    );
  }
}
