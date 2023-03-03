import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user.dart';

class UserProvider with ChangeNotifier {
  String? uid;
  String? email;
  String? username;
  Users? loginUser;

  Future<void> createUser(String name) async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    username = name;
    email = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(Users(id: uid, email: email, name: name).toJson())
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add User: $error"));
  }

  Future<void> getLoginUser() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    loginUser = Users.fromJson(data.data()!);
    username = loginUser!.name!;
  }
}
