import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                //tileColor: Color(0xFF1B2152),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                style: Theme.of(context).listTileTheme.style,
                title: const Text('Logout'),
                trailing: IconButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    icon: const Icon(Icons.logout)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
