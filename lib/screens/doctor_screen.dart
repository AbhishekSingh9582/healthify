import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/doctor.dart';
import '../provider/doctor_provider.dart';
import 'confirm_appointment.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<DoctorProvider>(context, listen: false).fetchDoctors(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading.....'),
            );
          } else if (snapshot.hasError) {
            print('Error Occured');
            return AlertDialog(
              title: Text('Something Went Wrong!\n Try again Later'),
              actions: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop,
                    icon: Icon(Icons.close))
              ],
            );
          } else {
            List<Doctor>? doctorsList = snapshot.data;
            return doctorsList!.isEmpty
                ? Center(
                    child: Text(
                      'No Doctors Available',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color.fromARGB(255, 253, 242, 207),
                    ),
                    child: Column(children: [
                      const SizedBox(height: 9),
                      Container(height: 6, width: 45, color: Colors.black),
                      const SizedBox(height: 13),
                      Text('Docotors',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 4),
                      ...doctorsList
                          .map((doctor) => DoctorWidget(doctor))
                          .toList()
                    ]),
                  );
          }
        }));
  }
}

class DoctorWidget extends StatelessWidget {
  Doctor doctor;
  DoctorWidget(this.doctor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 248, 224, 153),
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundImage: NetworkImage(
              doctor.doctorImage.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${doctor.name}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          ...List.generate(
                              5,
                              (index) => Icon(
                                    index < doctor.star!
                                        ? Icons.star
                                        : Icons.star_border_outlined,
                                    size: 18.5,
                                    color: Color.fromARGB(255, 228, 137, 0),
                                  ))
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${doctor.category}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text('${doctor.experience}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700))
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) =>
                                    ComfirmAppointment(doctor)))),
                        child: const Text('Book Consult')),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
