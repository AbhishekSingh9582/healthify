import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'upcoming_appointment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  var _loadedInitState = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_loadedInitState) {
      await Provider.of<UserProvider>(context, listen: false).getLoginUser();
      Future.delayed(Duration(milliseconds: 1500));
    }
    _loadedInitState = false;
  }

  final screens = [
    HomeScreen(),
    UpcomingAppointment(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF02012D),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF1B2152),
            iconSize: 28,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
                  currentIndex = index;
                }),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book_online), label: 'Appointment'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account'),
            ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: screens[currentIndex],
      ),
    );
  }
}
