import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/user_model.dart';
import '../widgets/home_screen_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<UserModel>(
        future: firebaseService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data available'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, ${user.name}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(user.governorate,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeScreenButton(
                        icon: Icons.payment,
                        label: 'Pay Bills',
                        onTap: () {
                          Navigator.pushNamed(context, '/payBills');
                        },
                      ),
                      HomeScreenButton(
                        icon: Icons.report_problem,
                        label: 'Report Issues',
                        onTap: () {
                          Navigator.pushNamed(context, '/reportIssues');
                        },
                      ),
                      HomeScreenButton(
                        icon: Icons.insert_drive_file,
                        label: 'Gov. Documents',
                        onTap: () {
                          Navigator.pushNamed(context, '/govDocuments');
                        },
                      ),
                      HomeScreenButton(
                        icon: Icons.local_hospital,
                        label: 'Emergency Services',
                        onTap: () {
                          Navigator.pushNamed(context, '/emergencyServices');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/calendar');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
