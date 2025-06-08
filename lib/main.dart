// Step 1: Flutter basics import
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'displaydatapage.dart'; // Import the display data page

// Step 2: main() function - app entry point
void main() {
  runApp(const MyApp());
}

// Step 3: StatelessWidget for app structure
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact Form',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ContactFormPage(),
    );
  }
}

// Step 4: ContactFormPage create panrom
class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

// Step 5: State create panrom
class _ContactFormPageState extends State<ContactFormPage> {
  // Text controllers for name, email, message
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // validation for textfields
  final _formkey = GlobalKey<FormState>();

  // Save form data locally
  Future<void> saveFormData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('message', messageController.text);
    debugPrint("✅ Form data saved locally!");
  }

  // Dispose controllers
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  // UI design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // Name TextField
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

              // Email TextField
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

              // Message TextField
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

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    await saveFormData(); // Step 3.1: Save data

                    // Step 3.2: Navigate to new page after saving
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DisplayDataPage(),
                      ),
                    );

                    // Step 3.3: Clear fields
                    nameController.clear();
                    emailController.clear();
                    messageController.clear();
                  }

                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
