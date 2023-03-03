import 'package:flutter/material.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/doctor.dart';

class ComfirmAppointment extends StatefulWidget {
  Doctor doctor;
  ComfirmAppointment(this.doctor, {super.key});

  @override
  State<ComfirmAppointment> createState() => _ComfirmAppointmentState();
}

class _ComfirmAppointmentState extends State<ComfirmAppointment> {
  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  String uid = '';
  DateTime? _choosenDate;
  bool _isLoading = false;
  int tag = 1;

  List<String> options = [
    '8:30 am',
    '8:40 am',
    '9:00 am',
    '9:20 am',
    '9:40 am',
    '1:30 pm',
    '2:00 pm',
    '2:30 pm',
    '8:20 pm',
    '8:40 pm',
    '9:00 pm',
  ];

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _choosenDate = pickedDate;
      });
    });
  }

  void _confirmBooking() {
    if (_choosenDate == null) return;
    setState(() {
      _isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('appointments')
        .doc()
        .set({
      'date': _choosenDate,
      'time': options[tag],
      'doctorName': widget.doctor.name,
      'speciality': widget.doctor.category
    }).then((value) {
      setState(() {
        _isLoading = false;

        Navigator.of(context).pop();
      });
      print("Appointment Set");
    }).catchError((error) => print("Failed to book Appointment: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title:
              Text('Appointment', style: Theme.of(context).textTheme.headline6),
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ElevatedButton(
            onPressed: _confirmBooking,
            child: _isLoading
                ? SizedBox(
                    width: 40,
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ))
                : const Text('Confirm Appointment')),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: _presentDatePicker,
                      child: const Text('Pick Date')),
                  Text(_choosenDate == null
                      ? 'Appointment Date:                          '
                      : 'Appointment Date: ${_choosenDate!.day}/${_choosenDate!.month}/${_choosenDate!.year}')
                ],
              ),
              SizedBox(height: 30),
              Text('Available Slots',
                  style: Theme.of(context).textTheme.headline5),
              ChipsChoice.single(
                value: tag,
                onChanged: ((value) => setState(() {
                      tag = value;
                    })),
                choiceItems: C2Choice.listFrom<int, String>(
                  source: options,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                spacing: 15,
                choiceStyle: C2ChoiceStyle(
                  color: Colors.blue,
                  borderColor: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                choiceActiveStyle: C2ChoiceStyle(
                  color: Colors.white,
                  backgroundColor: Color.fromARGB(255, 54, 57, 244),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                wrapped: true,
              ),
            ],
          ),
        ));
  }
}
