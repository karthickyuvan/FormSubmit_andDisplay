import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayDataPage extends StatelessWidget {
  const DisplayDataPage({super.key});
    // Step 2.1: Read data from shared preferences
  Future<Map<String, String>> getSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? 'No name';
    final email = prefs.getString('email') ?? 'No email';
    final message = prefs.getString('message') ?? 'No message';

    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Saved Data')),
      body: FutureBuilder<Map<String, String>>(
        future: getSavedData(), // Step 2.3: Call the function to get data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${data['name']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Email: ${data['email']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Message: ${data['message']}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),);
  }
}