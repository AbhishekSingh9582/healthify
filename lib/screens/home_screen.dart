import 'package:flutter/material.dart';
import 'package:healthify/provider/doctor_provider.dart';
import 'package:healthify/provider/medicine_provider.dart';
import '../provider/labtest_provider.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../model/article.dart';
import '../provider/article_provider.dart';
import 'medicine_screen.dart';
import 'labTest_screen.dart';
import 'doctor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? loginUserName = '';
  @override
  void initState() {
    loginUserName = Provider.of<UserProvider>(context, listen: false).username;
    super.initState();
  }

  void _showModalBottomSheet(BuildContext ctx, Widget selectedScreen) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: ((context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.8,
            maxChildSize: 0.9,
            minChildSize: 0.32,
            builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (context) => MedicineProvider()),
                      ChangeNotifierProvider(
                          create: (context) => LabTestProvider()),
                      ChangeNotifierProvider(
                          create: (context) => DoctorProvider()),
                    ],
                    child: selectedScreen,
                  ),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              ListTile(
                tileColor: Color(0xFF02012D),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Images/personFace.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                title: const Text('Hello!'),
                subtitle: Text('${loginUserName}'),
              ),
              const SizedBox(height: 10),
              Text(
                'Category',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GridWidget(
                      icon: Icons.tablet,
                      assetImage: 'assets/Images/medicine-image.avif',
                      title: 'Medicine',
                      onTap: () =>
                          _showModalBottomSheet(context, MedicineScreen()),
                    ),
                    GridWidget(
                      icon: Icons.report,
                      title: 'Lab Test',
                      assetImage: 'assets/Images/labTest.avif',
                      onTap: () =>
                          _showModalBottomSheet(context, LabTestScreen()),
                    ),
                    GridWidget(
                        icon: Icons.local_hospital,
                        title: 'Doctors',
                        assetImage: 'assets/Images/medical-background.avif',
                        onTap: () =>
                            _showModalBottomSheet(context, DoctorScreen())),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Articles',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF1B2152),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14))),
                //margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.4,

                child: FutureBuilder(
                  future: Provider.of<ArticleProvider>(context, listen: false)
                      .fetchArticle(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Text(
                        'Loading',
                        style: Theme.of(context).textTheme.headline2,
                      ));
                    } else {
                      List<Article> articles = snapshot.data;
                      return ListView.builder(
                        itemBuilder: ((context, index) => Column(
                              children: [
                                ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(articles[
                                                          index]
                                                      .imageUrl ??
                                                  'https://dryuc24b85zbr.cloudfront.net/tes/resources/11309676/image?width=500&height=500&version=1482966636358'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  title: Text(articles[index].title ?? ''),
                                  subtitle: Text(
                                    '${articles[index].description!.substring(0, 50)}...',
                                    softWrap: true,
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xFF02012D),
                                )
                              ],
                            )),
                        itemCount: 3,
                      );
                    }
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF1B2152),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14))),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.only(top: 0.8),
                child: Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text('View More',
                          style: Theme.of(context).textTheme.headline2)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GridWidget extends StatelessWidget {
  IconData? icon;
  String? assetImage;
  String? title;
  void Function()? onTap;
  GridWidget({
    this.icon,
    this.title,
    this.assetImage,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          //color: Color(0xFF1B2152),
          decoration: BoxDecoration(
              color: Color(0xFF1B2152),
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(7),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(assetImage!))),
                ),
              ),
              //Icon(icon),
              Text('$title', style: Theme.of(context).textTheme.headline2),
            ]),
          ),
        ),
      ),
    );
  }
}
