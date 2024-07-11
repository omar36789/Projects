import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';

class GovDocumentsScreen extends StatelessWidget {
  const GovDocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Documents'),
      ),
      body: FutureBuilder<List<String>>(
        future:
            firebaseService.getGovDocuments(firebaseService.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No documents available');
          } else {
            final documents = snapshot.data!;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(documents[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
