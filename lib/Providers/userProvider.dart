import 'package:bookeater/Methods/FIrebaseAuthMethods.dart';
import 'package:bookeater/Models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel get getUser => _user!;

  Future<void> refreshUser() async {
    UserModel user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
