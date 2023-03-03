import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/lab_test.dart';

class LabTestProvider with ChangeNotifier {
  List<LabTest>? _labTestList = [];

  List<LabTest> get getLabTestList {
    return [..._labTestList!];
  }

  Future<List<LabTest>> fetchLabTests() async {
    List<LabTest> lst = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('labTest').get();
      snapshot.docs.forEach((element) {
        lst.add(LabTest.fromJson(element.data()));
      });
      _labTestList = lst;
    } catch (error) {
      print(error);
    }
    return lst;
  }
}
