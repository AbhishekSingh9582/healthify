import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpcomingAppointment extends StatelessWidget {
  UpcomingAppointment({super.key});
  String? uid;
  @override
  Widget build(BuildContext context) {
    uid = FirebaseAuth.instance.currentUser!.uid;
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('appointments')
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something is wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<QueryDocumentSnapshot> lst = snapshot.data!.docs;
          if (lst.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Appointments Yet!',
                    style: Theme.of(context).textTheme.headline3),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Book Consultation with our experts Now',
                    style: Theme.of(context).textTheme.headline2,
                    softWrap: true,
                  ),
                )
              ],
            ));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                Text('Upcoming Appoiments',
                    style: Theme.of(context).textTheme.headline3),
                const SizedBox(height: 20),
                ...lst
                    .map((data) => Container(
                          color: Color(0xFF1B2152),
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Date',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  Text(
                                      data['date']
                                          .toDate()
                                          .toString()
                                          .split(' ')
                                          .first,
                                      style:
                                          Theme.of(context).textTheme.headline2)
                                ],
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Time',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                    Text(
                                      '${data['time']}',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Doctor',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                    Text(
                                      '${data['doctorName']}',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    )
                                  ]),
                            ],
                          ),
                        ))
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
