import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../services/firebase_service.dart';
import 'dart:io';

class ReportIssuesScreen extends StatefulWidget {
  const ReportIssuesScreen({Key? key}) : super(key: key);

  @override
  _ReportIssuesScreenState createState() => _ReportIssuesScreenState();
}

class _ReportIssuesScreenState extends State<ReportIssuesScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = Provider.of<FirebaseService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issues'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            _image != null
                ? Image.file(_image!)
                : const Text('No image selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_image != null) {
                  final imageUrl = await firebaseService.uploadFile(_image!);
                  final issueData = {
                    'description': _descriptionController.text,
                    'imageUrl': imageUrl,
                    'userId': firebaseService.currentUser!.uid,
                  };
                  await firebaseService.reportIssue(issueData);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
