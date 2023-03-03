import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/medicine.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine>? _medList = [];

  List<Medicine> get getMedList {
    return [..._medList!];
  }

  Future<List<Medicine>> fetchMedicines() async {
    List<Medicine> lst = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('medicines').get();
      snapshot.docs.forEach((element) {
        lst.add(Medicine.fromJson(element.data()));
      });
      _medList = lst;
    } catch (error) {
      print(error);
    }
    return lst;
  }
}
