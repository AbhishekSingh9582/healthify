import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/medicine.dart';
import '../provider/medicine_provider.dart';

class MedicineScreen extends StatelessWidget {
  MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<MedicineProvider>(context, listen: false)
          .fetchMedicines(),
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
          List<Medicine> medList = snapshot.data;
          return medList.isEmpty
              ? Center(
                  child: Text(
                    'No Medicines',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 9),
                    Container(height: 6, width: 45, color: Colors.black),
                    const SizedBox(height: 13),
                    Text('Medicines',
                        style: Theme.of(context).textTheme.headline6),
                    const SizedBox(height: 4),
                    ...medList.map((med) => MedicineWidget(med)).toList()
                  ],
                );
        }
      },
    );
  }
}

class MedicineWidget extends StatelessWidget {
  Medicine? med;
  MedicineWidget(this.med, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      // height: 27,
      margin: const EdgeInsets.all(15),

      child: GestureDetector(
        // onTap: () => Navigator.of(context).push(
        //     MaterialPageRoute(builder: (ctx) => BookDetailScreen(book.id))),
        onTap: () {},
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   (index + 1).toString(),
                //   style: Theme.of(context).textTheme.headline2,
                // ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: AspectRatio(
                    aspectRatio: 2 / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.5),
                      child: Image.network(
                        med!.imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 7,
                ),
                Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${med!.name}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      // ...(book.author as List<String>).map(
                      //   (e) => Text('$e '),
                      // ),
                      Text(
                        '${med!.quantity}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        'Rs ${med!.price}',
                        style: Theme.of(context).textTheme.headline5,
                      ),

                      FittedBox(
                        fit: BoxFit.fill,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent),
                            child: const Center(
                                child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.black),
                            ))),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
