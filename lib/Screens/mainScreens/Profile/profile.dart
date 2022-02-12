import 'package:bookeater/Methods/FIrebaseAuthMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkline/sparkline.dart';

import '../../../constants.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<double> data = [1, 2, 6, 3, 8, -1, 10, 7, 6];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ShadowContainer(
            child: Sparkline(
              data: data,
              pointSize: 1,
            ),
          ),
          ShadowContainer(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
                onPressed: () async {
                  await AuthMethods().signOut();
                },
                child: Text('Logout')),
          ),
        ],
      ),
    );
  }
}

class ShadowContainer extends StatelessWidget {
  final Widget child;
  ShadowContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        border: blackBorder,
        color: Colors.white,
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
      child: child,
    );
  }
}
