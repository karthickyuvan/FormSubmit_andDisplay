// Step 1: Import required packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For saving data locally
import 'displaydatapage.dart'; // Import the page where we show saved data

// Step 2: main() function - app execution starts here
void main() {
  runApp(const MyApp());
}

// Step 3: MyApp widget - app structure & theme set panrom
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'Contact Form', // App title
      theme: ThemeData(primarySwatch: Colors.blue), // Set app theme
      home: const ContactFormPage(), // First page to show when app opens
    );
  }
}

// Step 4: ContactFormPage - Stateful widget to manage form inputs
class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

// Step 5: Create state class - logic & UI build panrom
class _ContactFormPageState extends State<ContactFormPage> {
  // Step 6: TextEditingControllers to get text field values
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // Step 7: Form key to manage validation
  final _formkey = GlobalKey<FormState>();

  // Step 8: Function to save data locally using SharedPreferences
  Future<void> saveFormData() async {
    final prefs = await SharedPreferences.getInstance(); // Get SharedPreferences instance
    await prefs.setString('name', nameController.text); // Save name
    await prefs.setString('email', emailController.text); // Save email
    await prefs.setString('message', messageController.text); // Save message
    debugPrint("✅ Form data saved locally!");
  }

  // Step 9: Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  // Step 10: Build UI with Scaffold, AppBar and Form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Form')), // App bar with title
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Outer padding
        child: Form(
          key: _formkey, // Assign form key
          child: Column(
            children: [
              // Step 11: Name field with validation
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Step 12: Email field with validation
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Step 13: Message field with validation
              TextFormField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Message',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Step 14: Submit button to validate and navigate
              ElevatedButton(
                onPressed: () async {
                  // Step 14.1: Validate all fields
                  if (_formkey.currentState!.validate()) {
                    // Step 14.2: Save data to local storage
                    await saveFormData();

                    // Step 14.3: Navigate to DisplayDataPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DisplayDataPage(),
                      ),
                    );

                    // Step 14.4: Clear input fields after submission
                    nameController.clear();
                    emailController.clear();
                    messageController.clear();
                  }
                },
                child: const Text('Submit'), // Button text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
