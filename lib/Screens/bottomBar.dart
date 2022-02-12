import 'package:bookeater/Providers/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'mainScreens/Books/demoHome.dart';
import 'mainScreens/Profile/profile.dart';
import 'mainScreens/Words/wordBankScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //Variables
  int _currentIndex = 0;

  //Functions
  void setcurrentIndex(int i) {
    setState(() {
      _currentIndex = 1;
    });
  }

  //Refresh User
  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    await userProvider.refreshUser();
    print('current user: ${userProvider.getUser.name}');
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Saturday'),
            ],
          ),
        ),
        body: PageView(
          children: [
            DemoHome(),
            WordBankScreen(
              uid: userProvider.getUser.uid,
            ),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                title: Text('Books'),
                icon: InkWell(
                    onTap: () => {setcurrentIndex(0)},
                    child: Icon(FontAwesomeIcons.book))),
            BottomNavigationBarItem(
                title: Text('Words'),
                icon: InkWell(
                    onTap: () => {setcurrentIndex(1)},
                    child: Icon(FontAwesomeIcons.book))),
            BottomNavigationBarItem(
                title: Text('Sats'),
                icon: InkWell(
                    onTap: () => {setcurrentIndex(2)},
                    child: Icon(FontAwesomeIcons.book))),
          ],
        ),
      ),
    );
  }
}
