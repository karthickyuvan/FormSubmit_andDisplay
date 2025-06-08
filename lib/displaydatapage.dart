// Step 1: Import required packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For local storage

// Step 2: Create a stateless widget to show saved data
class DisplayDataPage extends StatelessWidget {
  const DisplayDataPage({super.key});

  // Step 2.1: Function to read data from SharedPreferences
  Future<Map<String, String>> getSavedData() async {
    final prefs = await SharedPreferences.getInstance(); // Get shared preferences instance
    final name = prefs.getString('name') ?? 'No name'; // Get saved name
    final email = prefs.getString('email') ?? 'No email'; // Get saved email
    final message = prefs.getString('message') ?? 'No message'; // Get saved message

    // Step 2.2: Return the data as a map
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }

  // Step 3: Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Data')), // App bar with title

      // Step 3.1: Use FutureBuilder to wait for data from getSavedData()
      body: FutureBuilder<Map<String, String>>(
        future: getSavedData(), // Step 3.2: Trigger async data fetch
        builder: (context, snapshot) {
          // Step 3.3: While waiting for data, show loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Step 3.4: If no data is found
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          // Step 3.5: Once data is ready, show it on screen
          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0), // Add padding around content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
              children: [
                // Step 3.6: Show each field
                Text('Name: ${data['name']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Email: ${data['email']}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('Message: ${data['message']}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
