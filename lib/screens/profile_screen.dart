import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/user_model.dart'; // Add this line to import UserModel
import 'transaction_history_screen.dart';
import 'account_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<UserModel>(
              future: firebaseService.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error');
                } else if (!snapshot.hasData) {
                  return const Text('No Data');
                } else {
                  final user = snapshot.data!;
                  return Column(
                    children: [
                      Text('Name: ${user.name}'),
                      Text('Email: ${user.email}'),
                      Text('Governorate: ${user.governorate}'),
                      Text('Mobile Number: ${user.mobileNumber}'),
                      Text('National ID: ${user.nationalId}'),
                    ],
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransactionHistoryScreen()),
                );
              },
              child: const Text('Transaction History'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSettingsScreen()),
                );
              },
              child: const Text('Account Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                await firebaseService.signOut();
                Navigator.pushReplacementNamed(context, '/signIn');
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
