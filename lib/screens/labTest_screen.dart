import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/lab_test.dart';
import '../provider/labtest_provider.dart';

class LabTestScreen extends StatelessWidget {
  const LabTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<LabTestProvider>(context).fetchLabTests(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
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
            List<LabTest> labTest = snapshot.data;
            return labTest.isEmpty
                ? Center(
                    child: Text(
                      'No Tests Available',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )
                : Column(children: [
                    SizedBox(height: 9),
                    Container(height: 6, width: 45, color: Colors.black),
                    const SizedBox(height: 13),
                    Text('Lab Tests',
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 4),
                    ...labTest.map((test) => LabTestWidget(test)).toList()
                  ]);
          }
        });
  }
}

class LabTestWidget extends StatelessWidget {
  LabTest? test;
  LabTestWidget(this.test, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(
                flex: 1,
                child: CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/Images/lab-flask.png')),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${test!.testLabel}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                                  Color.fromARGB(255, 186, 231, 209)),
                          onPressed: () => showDialog(
                                context: context,
                                builder: (context) => FittedBox(
                                  fit: BoxFit.contain,
                                  child: AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('${test!.testLabel}'),
                                        IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(color: Colors.grey),
                                        ...test!.testList!
                                            .map((e) => Text(
                                                  '*  ${e}',
                                                ))
                                            .toList()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Include ${test!.totalTestInclude} tests',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                Text('Show All',
                                    style:
                                        Theme.of(context).textTheme.headline4)
                              ])),
                    ),
                    Text('Rs ${test!.price}',
                        style: Theme.of(context).textTheme.headline5),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
