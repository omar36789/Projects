import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import '../models/bill_model.dart';

class PayBillsScreen extends StatelessWidget {
  const PayBillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills Payment'),
      ),
      body: FutureBuilder<List<BillModel>>(
        future: firebaseService.getBills(firebaseService.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No bills available');
          } else {
            final bills = snapshot.data!;
            return ListView.builder(
              itemCount: bills.length,
              itemBuilder: (context, index) {
                final bill = bills[index];
                return ListTile(
                  title: Text('${bill.month} - ${bill.details}'),
                  subtitle: Text('${bill.price} IQD'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await firebaseService.payBill(
                          firebaseService.currentUser!.uid, bill);
                    },
                    child: const Text('Pay'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
