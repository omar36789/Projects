import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pay_bills_screen.dart';
import 'screens/report_issues_screen.dart';
import 'screens/gov_documents_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/transaction_history_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/account_settings_screen.dart';
import 'screens/emergency_services_screen.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseService>(create: (_) => FirebaseService()),
      ],
      child: MaterialApp(
        title: 'Capstone App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SignInScreen(),
        routes: {
          '/signIn': (context) => const SignInScreen(),
          '/signUp': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/payBills': (context) => const PayBillsScreen(),
          '/reportIssues': (context) => const ReportIssuesScreen(),
          '/govDocuments': (context) => const GovDocumentsScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/transactionHistory': (context) => const TransactionHistoryScreen(),
          '/calendar': (context) => const CalendarScreen(),
          '/accountSettings': (context) => const AccountSettingsScreen(),
          '/emergencyServices': (context) => const EmergencyServicesScreen(),
        },
      ),
    );
  }
}
