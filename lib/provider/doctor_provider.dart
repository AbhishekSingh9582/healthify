import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/doctor.dart';

class DoctorProvider with ChangeNotifier {
  List<Doctor>? _docList = [];

  List<Doctor> get getMedList {
    return [..._docList!];
  }

  Future<List<Doctor>> fetchDoctors() async {
    List<Doctor> lst = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('doctor').get();
      snapshot.docs.forEach((element) {
        lst.add(Doctor.fromJson(element.data()));
      });
      _docList = lst;
    } catch (error) {
      print(error);
    }
    return lst;
  }
}
