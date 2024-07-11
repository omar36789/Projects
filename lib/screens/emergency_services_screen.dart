import 'package:flutter/material.dart';

class EmergencyServicesScreen extends StatelessWidget {
  const EmergencyServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Services'),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Police Department'),
            trailing: ElevatedButton(
              onPressed: null, // Add call function here
              child: Text('Call'),
            ),
          ),
          ListTile(
            title: Text('Fire Department'),
            trailing: ElevatedButton(
              onPressed: null, // Add call function here
              child: Text('Call'),
            ),
          ),
          ListTile(
            title: Text('Traffic Police Department'),
            trailing: ElevatedButton(
              onPressed: null, // Add call function here
              child: Text('Call'),
            ),
          ),
        ],
      ),
    );
  }
}
