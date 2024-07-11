import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAddBillScreen extends StatefulWidget {
  const AdminAddBillScreen({super.key});

  @override
  _AdminAddBillScreenState createState() => _AdminAddBillScreenState();
}

class _AdminAddBillScreenState extends State<AdminAddBillScreen> {
  final _detailsController = TextEditingController();
  final _monthController = TextEditingController();
  final _priceController = TextEditingController();

  Future<void> _addBill() async {
    if (_detailsController.text.isNotEmpty &&
        _monthController.text.isNotEmpty &&
        _priceController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('bills').add({
        'details': _detailsController.text,
        'month': _monthController.text,
        'price': _priceController.text,
      });
      // Clear the text fields
      _detailsController.clear();
      _monthController.clear();
      _priceController.clear();
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bill added successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Bill')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
            TextField(
              controller: _monthController,
              decoration: const InputDecoration(labelText: 'Month'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addBill,
              child: const Text('Add Bill'),
            ),
          ],
        ),
      ),
    );
  }
}
