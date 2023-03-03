import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import './provider/user_provider.dart';
import './provider/article_provider.dart';
import './screens/home_page.dart';
import './screens/auth_page.dart';
import './provider/medicine_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zarity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF02012D), //Color.fromRGBO(27, 33, 82, 1),
          //backgroundColor: Color(0xFF02012D),
          primarySwatch: Colors.indigo,
          //scaffoldBackgroundColor: Color(0xFF02012D),//#1B2152
          iconTheme: IconThemeData(color: Colors.white, size: 20),
          listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            iconColor: Colors.white,
            tileColor: Color(0xFF1B2152),
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
            headline2: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            headline3: TextStyle(
                fontSize: 21, fontWeight: FontWeight.w800, color: Colors.white),
            headline4: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
            headline5: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            headline6: TextStyle(
                fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              iconTheme: IconThemeData(color: Colors.white))),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => ArticleProvider()),
          ChangeNotifierProvider(create: ((context) => MedicineProvider()))
        ],
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              } else if (snapshot.hasData) {
                return HomePage();
              } else {
                return AuthPage();
              }
            }),
      ),
    );
  }
}
