import 'package:bookeater/Providers/word_bank.dart';
import 'package:bookeater/Widgets/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../add_word.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordBank>(
      builder: (context, wordbank, child) => Scaffold(
        backgroundColor: Colors.indigo.shade50,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Name Card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: gilroyMedium,
                        ),
                        Text(
                          'Rituraj Tripathy',
                          style: gilroyBold30,
                        ),
                        Text(
                          'What would You read Today?',
                          style: gilroyRegular,
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 30,
                    ),
                  ],
                ),
                const SizedBox(height: 70),
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
                    children: wordbank
                        .onlyWords()
                        .map(
                          (word) => GestureDetector(
                              onTap: () {}, child: TextBox(text: word)),
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
                  itemCount: wordbank.tagList.length,
                  itemBuilder: (context, index) => TextBox(
                    text: wordbank.tagList[index],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddWord()),
            );
          },
          child: Icon(FontAwesomeIcons.plus),
        ),
      ),
    );
  }
}
